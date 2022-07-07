import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/pin_code_field.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code__desktop_input/pin_code_desktop_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePinCodeArea extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;
  final bool isDesktop;

  const CreatePinCodeArea({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final pinCodeBloc = context.read<PinCodeBloc>();

    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state is PinCodeInitialState
                        ? AppLocalizations.of(context)!.createPinCode
                        : AppLocalizations.of(context)!.repeatPinCode,
                    style: theme.textTheme.header,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 24,
                    child: Text(
                      state is PinCodeInitialState ? AppLocalizations.of(context)!.itWillBeNeedToEnter : '',
                      style: theme.textTheme.px14.copyWith(color: theme.text),
                    ),
                  ),
                  const SizedBox(height: 46),
                  Center(
                    child: SizedBox(
                      height: 20,
                      child: Text(
                        state is PinCodeNotMatch ? AppLocalizations.of(context)!.pinNotCorrect : '',
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
                  pinCodeBloc.add(state is PinCodeEditing ? RepeatPinCode(value) : CreatePinCode(value));
                },
              )
            else
              PinCodeField(
                forceErrorState: state is PinCodeNotMatch,
                pinCodeController: pinController,
                pinCodeFocusNode: pinFocusNode,
                onCompleted: (value) {
                  pinCodeBloc.add(state is PinCodeEditing ? RepeatPinCode(value) : CreatePinCode(value));
                },
              ),
          ],
        );
      },
    );
  }
}
