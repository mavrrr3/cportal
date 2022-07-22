import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

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
          final textStyle = isWrongCode ? theme.textTheme.px16.copyWith(color: theme.red) : theme.textTheme.px16;
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
                onTap: () => context.pushNamed(
                  isDesktop ? NavigationRouteNames.connectingCodeInfo : NavigationRouteNames.connectingCodeInfoMobile,
                ),
                child: Text(
                  AppLocalizations.of(context)!.howToGetConnectingCode,
                  style: theme.textTheme.px14.copyWith(
                    color: theme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: codeAreaColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: codeController,
                  focusNode: codeFocusNode,
                  style: textStyle,
                  textCapitalization: TextCapitalization.characters,
                  // cursorHeight: 16,
                  autocorrect: false,
                  cursorColor: theme.primary,
                  decoration: InputDecoration(
                    focusedBorder: focusedBorder,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 20,
                child: state is TryAgainLater
                    ? Text(
                        strings.tryToRepeatAfter30sec,
                        style: theme.textTheme.px14,
                      )
                    : state is WrongConnectingCode
                        ? Text(
                            strings.wrongConnectingCode,
                            style: theme.textTheme.px14.copyWith(
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
