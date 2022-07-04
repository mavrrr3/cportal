import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_desktop/create_pin_code_desktop_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_mobile/create_pin_code_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CreatePinCodeScreen extends StatefulWidget {
  const CreatePinCodeScreen({Key? key}) : super(key: key);

  @override
  State<CreatePinCodeScreen> createState() => _CreatePinCodeScreenState();
}

class _CreatePinCodeScreenState extends State<CreatePinCodeScreen> {
  final pinController = TextEditingController();
  final pinFocusNode = FocusNode()..requestFocus();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state is PinCodeSuccessfullyChanged) {
          context.read<BiometricBloc>().add(const CheckBiometricSupport());
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
            context.goNamed(NavigationRouteNames.mainPage);
          }
        },
        child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
            ? CreatePinCodeDesktopScreen(pinController: pinController, pinFocusNode: pinFocusNode)
            : CreatePinCodeMobileScreen(pinController: pinController, pinFocusNode: pinFocusNode),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }
}
