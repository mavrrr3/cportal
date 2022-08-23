// ignore_for_file: prefer_int_literals

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/login_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code/mobile_animations/pin_code_input_animation.dart';
import 'package:flutter/material.dart';

class MobilePinCodeField extends StatefulWidget {
  const MobilePinCodeField({
    Key? key,
  }) : super(key: key);

  @override
  State<MobilePinCodeField> createState() => _MobilePinCodeFieldState();
}

class _MobilePinCodeFieldState extends State<MobilePinCodeField> {
  late AnimationController _inputAnimationController1;
  late AnimationController _inputAnimationController2;
  late AnimationController _inputAnimationController3;
  late AnimationController _inputAnimationController4;

  late AnimationController _successAnimationController;
  late AnimationController _declinedAnimationController;

  @override
  void initState() {
    _inputAnimationController1 = context
        .findRootAncestorStateOfType<LoginScreenState>()!
        .inputAnimationController1;
    _inputAnimationController2 = context
        .findRootAncestorStateOfType<LoginScreenState>()!
        .inputAnimationController2;
    _inputAnimationController3 = context
        .findRootAncestorStateOfType<LoginScreenState>()!
        .inputAnimationController3;
    _inputAnimationController4 = context
        .findRootAncestorStateOfType<LoginScreenState>()!
        .inputAnimationController4;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: PinCodeInputAnimation(_inputAnimationController1).boxScale,
          child: AnimatedContainer(
            width: 16,
            height: 16,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isActive(1) ? theme.primary : theme.textLight,
            ),
          ),
        ),
        const SizedBox(width: 32),
        ScaleTransition(
          scale: PinCodeInputAnimation(_inputAnimationController2).boxScale,
          child: AnimatedContainer(
            width: 16,
            height: 16,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isActive(2) ? theme.primary : theme.textLight,
            ),
          ),
        ),
        const SizedBox(width: 32),
        ScaleTransition(
          scale: PinCodeInputAnimation(_inputAnimationController3).boxScale,
          child: AnimatedContainer(
            width: 16,
            height: 16,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isActive(3) ? theme.primary : theme.textLight,
            ),
          ),
        ),
        const SizedBox(width: 32),
        ScaleTransition(
          scale: PinCodeInputAnimation(_inputAnimationController4).boxScale,
          child: AnimatedContainer(
            width: 16,
            height: 16,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isActive(4) ? theme.primary : theme.textLight,
            ),
          ),
        ),
      ],
    );
  }

  bool _isActive(int i) {
    return context
            .findRootAncestorStateOfType<LoginScreenState>()!
            .pinController
            .text
            .length >=
        i;
  }
}
