import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/widgets/enter_pin_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/keyboard/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_mobile_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

class LoginMobileScreen extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;

  const LoginMobileScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;
    final authBloc = context.read<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AuthMobileLayout(
          appBarSuffix: state is HasAuthCredentials && state.enabledBiometric != null
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => authBloc.add(LogInWithBiometrics(strings.logInToContinue)),
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
                pinController: pinController,
                pinFocusNode: pinFocusNode,
              ),
              const Spacer(),
              CustomKeyboard(keyboardController: pinController),
            ],
          ),
        );
      },
    );
  }
}
