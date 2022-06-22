import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_mobile/connecting_code_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/connecting_code_web.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ConnectingCodeScreen extends StatefulWidget {
  const ConnectingCodeScreen({Key? key}) : super(key: key);

  @override
  State<ConnectingCodeScreen> createState() => _ConnectingCodeScreenState();
}

class _ConnectingCodeScreenState extends State<ConnectingCodeScreen> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWrapper.of(context).isLargerThan(TABLET)
          ? ConnectingCodeWeb(codeController: codeController)
          : ConnectingCodeMobile(codeController: codeController),
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }
}
