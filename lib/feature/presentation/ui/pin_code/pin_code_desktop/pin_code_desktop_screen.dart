import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/pin_code_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_desktop_layout.dart';
import 'package:flutter/material.dart';

class PinCodeDesktopScreen extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;
  final String firstTitle;
  final String secondTitle;

  const PinCodeDesktopScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
    required this.firstTitle,
    required this.secondTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthDesktopLayout(
      child: Column(
        children: [
          const SizedBox(height: 260),
          PinCodeArea(
            pinController: pinController,
            pinFocusNode: pinFocusNode,
            firstTitle: firstTitle,
            secondTitle: secondTitle,
            isDesktop: true,
          ),
        ],
      ),
    );
  }
}
