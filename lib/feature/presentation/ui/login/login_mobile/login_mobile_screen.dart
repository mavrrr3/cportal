// ignore_for_file: cascade_invocations

import 'dart:developer';

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/login_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/widgets/enter_pin_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/keyboard/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_mobile_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

class LoginMobileScreen extends StatefulWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;

  const LoginMobileScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
  }) : super(key: key);

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  @override
  Widget build(BuildContext context) {
    log(widget.pinController.text);
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;
    final authBloc = context.read<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthMobileLayout(
          appBarSuffix:
              state is HasAuthCredentials && state.enabledBiometric != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => authBloc
                          .add(LogInWithBiometrics(strings.logInToContinue)),
                      child: state.enabledBiometric == BiometricType.face
                          ? SvgPicture.asset(
                              ImageAssets.faceId,
                              color: theme.primary,
                              width: 32,
                              height: 32,
                            )
                          : SizedBox(
                              width: 32,
                              height: 32,
                              child: SvgPicture.asset(
                                ImageAssets.fingerPrint,
                                color: theme.primary,
                                width: 25,
                                height: 27,
                              ),
                            ),
                    )
                  : null,
          child: Column(
            children: [
              EnterPinArea(
                pinController: widget.pinController,
                pinFocusNode: widget.pinFocusNode,
              ),
              const Spacer(),
              CustomKeyboard(
                keyboardController: widget.pinController,
                tapCallBack: (i) async {
                  setState(() {});
                  log('---- $i');
                  final inputAnimationController = getCurrentController(i);
                  await inputAnimationController.forward();
                  inputAnimationController.stop();
                  await inputAnimationController.reverse();
                  inputAnimationController.reset();
                },
                onComplete: () => authBloc.add(
                  LogInWithPinCode(widget.pinController.text),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AnimationController getCurrentController(int i) {
    switch (i) {
      case 2:
        return context
            .findRootAncestorStateOfType<LoginScreenState>()!
            .inputAnimationController2;
      case 3:
        return context
            .findRootAncestorStateOfType<LoginScreenState>()!
            .inputAnimationController3;
      case 4:
        return context
            .findRootAncestorStateOfType<LoginScreenState>()!
            .inputAnimationController4;
      case 5:
        return context
            .findRootAncestorStateOfType<LoginScreenState>()!
            .inputAnimationController5;
      default:
        return context
            .findRootAncestorStateOfType<LoginScreenState>()!
            .inputAnimationController1;
    }
  }
}
