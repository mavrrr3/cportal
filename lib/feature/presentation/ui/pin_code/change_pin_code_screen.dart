import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_desktop/pin_code_desktop_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_mobile/pin_code_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final strings = AppLocalizations.of(context)!;
    final enterNewPinCode = strings.enterNewPinCode;
    final repeatPinCode = strings.repeatPinCode;

    return BlocListener<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state is PinCodeInitialState || state is PinCodeEditing) {
          pinController.clear();
          pinFocusNode.requestFocus();
        } else if (state is PinCodeSuccessfullyChanged) {
          context.goNamed(NavigationRouteNames.mainPage);
        }
      },
      child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
          ? PinCodeDesktopScreen(
              pinController: pinController,
              pinFocusNode: pinFocusNode,
              firstTitle: enterNewPinCode,
              secondTitle: repeatPinCode,
            )
          : PinCodeMobileScreen(
              pinController: pinController,
              pinFocusNode: pinFocusNode,
              firstTitle: enterNewPinCode,
              secondTitle: repeatPinCode,
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
