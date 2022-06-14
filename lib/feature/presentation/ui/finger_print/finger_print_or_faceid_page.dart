import 'dart:developer';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FingerPrintOrFaceIdPage extends StatelessWidget {
  final String route;

  const FingerPrintOrFaceIdPage({Key? key, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<BiometricBloc, BiometricState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SvgIcon(null, path: 'logo_grey.svg', width: 24),
                    ],
                  ),
                  const SizedBox(height: 31),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            state.getTitle(route, context),
                            style: theme.textTheme.headline2!
                                .copyWith(height: 1.286),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.doFingerPrintNotInputPin,
                        style:
                            theme.textTheme.headline6!.copyWith(height: 1.714),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  SvgIcon(
                    theme.hoverColor.withOpacity(0.1),
                    path: state.getPathIcon(route),
                    width: 149.21,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 62.87,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Button.factory(
                          context,
                          ButtonEnum.blue,
                          AppLocalizations.of(context)!.yes,
                          () {
                            BlocProvider.of<BiometricBloc>(
                              context,
                              listen: false,
                            ).add(const GetBiometricEvent());
                            log('isAuthenticated ${state.authStatus}');
                            log('Biometric list ${state.listBiometric}');
                          },
                          const Size(142, 48),
                        ),
                        Button.factory(
                          context,
                          ButtonEnum.outlined,
                          AppLocalizations.of(context)!.noThanks,
                          () async {
                            // TODO Реализовать функционал кнопки Нет, спасибо.
                          },
                          const Size(142, 48),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
