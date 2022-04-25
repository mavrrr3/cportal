import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:swipe/swipe.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isIOS) {
      controller!.resumeCamera();
    } else if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeRight: () => GoRouter.of(context).pop(),
      child: Scaffold(
        body: Stack(
          children: [
            QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderRadius: 12,
                borderLength: 20.h,
                borderWidth: 10.w,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
                borderColor: Theme.of(context).splashColor,
              ),
              onQRViewCreated: _onQrViewCreated,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 84.h),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    log('Flash');
                  },
                  child: SvgPicture.asset(
                    'assets/icons/flash_light.svg',
                    width: 48.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (_result != null)
              Text(
                '${_result!.code}',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
    );
  }

  void _onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
