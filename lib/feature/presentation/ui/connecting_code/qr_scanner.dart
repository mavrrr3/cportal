import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
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
  late CameraController _cameraController;
  late bool _isFlashLight;
  QRViewController? qrController;

  @override
  void initState() {
    super.initState();
    _isFlashLight = false;
    _cameraInit();
  }

  @override
  void reassemble() {
    super.reassemble();

    if (Platform.isIOS) {
      qrController!.resumeCamera();
    } else if (Platform.isAndroid) {
      qrController!.pauseCamera();
    }
  }

  /// For Camera Flash Light
  void _cameraInit() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
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
                    log('Flash Light $_isFlashLight');
                    if (_isFlashLight) {
                      _cameraController.setFlashMode(FlashMode.off);
                      setState(() {
                        _isFlashLight = false;
                      });
                    } else {
                      _cameraController.setFlashMode(FlashMode.always);
                      setState(() {
                        _isFlashLight = true;
                      });
                    }
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
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
      });
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
