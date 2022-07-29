import 'package:cportal_flutter/common/util/platform_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_desktop/pin_code_desktop_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_mobile/pin_code_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePinCodeScreen extends StatefulWidget {
  const CreatePinCodeScreen({Key? key}) : super(key: key);

  @override
  State<CreatePinCodeScreen> createState() => _CreatePinCodeScreenState();
}

class _CreatePinCodeScreenState extends State<CreatePinCodeScreen> {
  final pinController = TextEditingController();
  final pinFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final createPinCode = strings.createPinCode;
    final repeatPinCode = strings.repeatPinCode;

    return BlocListener<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state is PinCodeSuccessfullyChanged) {
          if (!kIsMobile || context.read<BiometricBloc>().state is BiometricNotSupported) {
            _logIn(context);
          } else {
            context.read<BiometricBloc>().add(const CheckBiometricSupport());
          }
        } else if (state is PinCodeInitialState || state is PinCodeEditing) {
          pinController.clear();
          pinFocusNode.requestFocus();
        }
      },
      child: BlocListener<BiometricBloc, BiometricState>(
        listener: (context, state) {
          if (state is BiometricSupported) {
            if (state.biometricType == BiometricType.face) {
              context.goNamed(NavigationRouteNames.enrollFaceId);
            } else {
              context.goNamed(NavigationRouteNames.enrollFingerPrint);
            }
          } else if (state is BiometricNotSupported) {
            _logIn(context);
          }
        },
        child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
            ? PinCodeDesktopScreen(
                pinController: pinController,
                pinFocusNode: pinFocusNode,
                firstTitle: createPinCode,
                secondTitle: repeatPinCode,
              )
            : PinCodeMobileScreen(
                pinController: pinController,
                pinFocusNode: pinFocusNode,
                firstTitle: createPinCode,
                secondTitle: repeatPinCode,
              ),
      ),
    );
  }

  void _logIn(BuildContext context) {
    final connectingCodeState = context.read<ConnectingCodeBloc>().state;
    final authState = context.read<AuthBloc>().state;

    if (connectingCodeState is AuthenticatedWithConnectingCode) {
      context.read<AuthBloc>().add(LogInWithUser(connectingCodeState.user));
      context.goNamed(NavigationRouteNames.mainPage);
    } else if (authState is Authenticated) {
      context.goNamed(NavigationRouteNames.mainPage);
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }
}
