import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/show_connecting_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterConnectingCode extends StatelessWidget {
  final bool isDesktop;
  final TextEditingController codeController;
  final FocusNode codeFocusNode;

  const EnterConnectingCode({
    Key? key,
    this.isDesktop = false,
    required this.codeController,
    required this.codeFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;

    return SizedBox(
      width: 320,
      child: BlocConsumer<ConnectingCodeBloc, ConnectingCodeState>(
        listener: (context, state) {
          if (state is ConnectingCodeInitial) {
            codeController.clear();
          }
        },
        builder: (context, state) {
          final isWrongCode = state is WrongConnectingCode;
          final inputTextStyle = theme.textTheme.px16.copyWith(height: 1.5);
          final errorCodeTextStyle = theme.textTheme.px14.copyWith(height: 1.43);
          final codeAreaColor = isWrongCode ? theme.lightRedPIN : theme.cardColor;
          final focusedBorder = isDesktop
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.primary!.withOpacity(0.34)),
                )
              : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.inputConnectingCode,
                style: theme.textTheme.header,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => showConnectingInfo(context),
                child: Text(
                  AppLocalizations.of(context)!.howToGetConnectingCode,
                  style: theme.textTheme.px14.copyWith(
                    color: theme.primary,
                    height: 1.43,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: codeAreaColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: codeController,
                  focusNode: codeFocusNode,
                  style: isWrongCode ? inputTextStyle.copyWith(color: theme.red) : inputTextStyle,
                  textCapitalization: TextCapitalization.characters,
                  autocorrect: false,
                  cursorColor: theme.primary,
                  cursorHeight: 24,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    focusedBorder: focusedBorder,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 20,
                child: state is TryAgainLater
                    ? Text(
                        strings.tryToRepeatAfter30sec,
                        style: errorCodeTextStyle,
                      )
                    : state is WrongConnectingCode
                        ? Text(
                            strings.wrongConnectingCode,
                            style: errorCodeTextStyle.copyWith(
                              color: theme.red!.withOpacity(0.6),
                            ),
                          )
                        : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
