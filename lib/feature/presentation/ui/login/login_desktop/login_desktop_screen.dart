import 'package:cportal_flutter/feature/presentation/ui/login/widgets/enter_pin_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_desktop_layout.dart';
import 'package:flutter/material.dart';

class LoginDesktopScreen extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;

  const LoginDesktopScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthDesktopLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 260),
          EnterPinArea(
            pinController: pinController,
            pinFocusNode: pinFocusNode,
            isDesktop: true,
          ),
        ],
      ),
    );
  }
}
