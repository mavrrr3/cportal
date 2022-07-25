import 'dart:io';

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool isStopped = false;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? qrController;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController!.pauseCamera();
    }
    qrController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeRight: context.pop,
      child: Scaffold(
        body: Stack(
          children: [
            QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderRadius: 12,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 220,
                borderColor: Colors.white,
                cutOutBottomOffset: 20,
              ),
              onQRViewCreated: (controller) => _onQrViewCreated(controller, context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 94),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: qrController?.toggleFlash,
                  child: SvgPicture.asset(
                    ImageAssets.flashLight,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQrViewCreated(QRViewController controller, BuildContext context) {
    setState(() {
      qrController = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (!isStopped) {
        context.pop();
        context.read<ConnectingCodeBloc>().add(ReadQrCode(scanData.code ?? ''));
      }

      setState(() {
        isStopped = true;
      });
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
