import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code/mobile_pin_code_field.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code/pin_code_desktop_input/pin_code_desktop_input.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/show_connecting_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPinArea extends StatefulWidget {
  final bool isDesktop;
  final TextEditingController pinController;
  final FocusNode pinFocusNode;

  const EnterPinArea({
    Key? key,
    this.isDesktop = false,
    required this.pinController,
    required this.pinFocusNode,
  }) : super(key: key);

  @override
  State<EnterPinArea> createState() => _EnterPinAreaState();
}

class _EnterPinAreaState extends State<EnterPinArea> {
  String wait30SecIfWrongEnteringCode = '30';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;
    final authBloc = context.read<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.inputPinCode,
                    style: theme.textTheme.header,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => showConnectingInfo(context),
                    child: SizedBox(
                      height: 24,
                      child: Text(
                        strings.forgetPin,
                        style:
                            theme.textTheme.px14.copyWith(color: theme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 46),
                  Center(
                    child: SizedBox(
                      height: 20,
                      child: state is TryAgainLater
                          ? StreamBuilder(
                              stream: state.wait30Seconds(),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data == null
                                      ? '${strings.tryToRepeatAfter} 30 секунд'
                                      : '${strings.tryToRepeatAfter} ${snapshot.data} секунд',
                                  style: theme.textTheme.px14,
                                );
                              },
                            )
                          : state is WrongPinCode
                              ? Text(
                                  strings.errorPinCode,
                                  style: theme.textTheme.px14.copyWith(
                                    color: theme.red,
                                  ),
                                )
                              : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            if (widget.isDesktop)
              PinCodeDesktopInput(
                onCompleted: (pinCode) =>
                    authBloc.add(LogInWithPinCode(context, pinCode)),
                forceErrorState: state is WrongPinCode,
                codeController: widget.pinController,
                codeFocusNode: widget.pinFocusNode,
              )
            else
              MobilePinCodeField(controller: widget.pinController),

            
          ],
        );
      },
    );
  }
}
