import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/pin_code_field.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code__desktop_input/pin_code_desktop_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ChangePinCodeArea extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;
  final bool isDesktop;

  const ChangePinCodeArea({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final pinCodeBloc = context.read<PinCodeBloc>();
    final localizedStrings = AppLocalizations.of(context)!;

    return BlocConsumer<PinCodeBloc, PinCodeState>(
      listener: (context, state) {
        if (state is PinCodeSuccessfullyChanged) {
          return context.goNamed(NavigationRouteNames.mainPage);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state is PinCodeInitialState ||
                            state is PinCodeSuccessfullyChanged
                        ? localizedStrings.enterNewPinCode
                        : localizedStrings.repeatPinCode,
                    style: theme.textTheme.header,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 24,
                    child: Text(
                      state is PinCodeInitialState
                          ? localizedStrings.itWillBeNeedToEnter
                          : '',
                      style: theme.textTheme.px14.copyWith(color: theme.text),
                    ),
                  ),
                  const SizedBox(height: 46),
                  Center(
                    child: SizedBox(
                      height: 20,
                      child: Text(
                        state is PinCodeNotMatch
                            ? localizedStrings.pinNotCorrect
                            : '',
                        style: theme.textTheme.px14.copyWith(
                          color: theme.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (isDesktop)
              PinCodeDesktopInput(
                forceErrorState: state is PinCodeNotMatch,
                codeController: pinController,
                codeFocusNode: pinFocusNode,
                onCompleted: (value) {
                  pinCodeBloc.add(state is PinCodeEditing
                      ? RepeatPinCode(value)
                      : CreatePinCode(value));
                },
              )
            else
              PinCodeField(
                forceErrorState: state is PinCodeNotMatch,
                pinCodeController: pinController,
                pinCodeFocusNode: pinFocusNode,
                onCompleted: (value) {
                  pinCodeBloc.add(state is PinCodeEditing
                      ? RepeatPinCode(value)
                      : CreatePinCode(value));
                },
              ),
          ],
        );
      },
    );
  }
}
