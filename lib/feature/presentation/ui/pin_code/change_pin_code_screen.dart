import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_desktop/change_pin_code_desktop_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_mobile/change_pin_code_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ChangePinCodeScreen extends StatefulWidget {
  const ChangePinCodeScreen({Key? key}) : super(key: key);

  @override
  State<ChangePinCodeScreen> createState() => _ChangePinCodeScreenState();
}

class _ChangePinCodeScreenState extends State<ChangePinCodeScreen> {
  final pinController = TextEditingController();
  final pinFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state is PinCodeSuccessfullyChanged) {
          context.read<BiometricBloc>().add(const CheckBiometricSupport());
        } else if (state is PinCodeInitialState || state is PinCodeEditing) {
          pinController.clear();
        }
      },
      child: BlocListener<BiometricBloc, BiometricState>(
        listener: (context, state) {
          final connectingCodeState = context.read<ConnectingCodeBloc>().state;

          if (connectingCodeState is AuthenticatedWithConnectingCode) {
            context
                .read<AuthBloc>()
                .add(LogInWithUser(connectingCodeState.user));
            context.goNamed(NavigationRouteNames.mainPage);
          }
        },
        child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
            ? ChangePinCodeDesktopScreen(
                pinController: pinController,
                pinFocusNode: pinFocusNode,
              )
            : ChangePinCodeMobileScreen(
                pinController: pinController,
                pinFocusNode: pinFocusNode,
              ),
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
