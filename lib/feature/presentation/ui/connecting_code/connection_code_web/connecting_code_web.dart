import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

final _codeController = TextEditingController();

final _codeFocusNode = FocusNode();

final _formKey = GlobalKey<FormState>();
bool _isWrongCode = false;

class ConnectingCodeWeb extends StatelessWidget {
  const ConnectingCodeWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) ...[
          const LoaderWebWidget(),
        ] else ...[
          const SizedBox(),
        ],
        const InputCodeBlocWidget(),
        const SizedBox(),
      ],
    );
  }
}

class InputCodeBlocWidget extends StatelessWidget {
  const InputCodeBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUser) {
          const String nextScreen = kIsWeb
              ? NavigationRouteNames.createPinWeb
              : NavigationRouteNames.createPin;

          context.goNamed(nextScreen);
        }
        if (state is ErrorAuthState) _isWrongCode = !_isWrongCode;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 260),
                    Text(
                      AppLocalizations.of(context)!.inputConnectingCode,
                      style: theme.textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push<dynamic>(MaterialPageRoute<dynamic>(
                            builder: (context) =>
                                const Scaffold(body: GetCodeWidget()),
                          )),
                          child: Text(
                            AppLocalizations.of(context)!
                                .howToGetConnectingCode,
                            style: theme.textTheme.headline6!.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 27),
                  ],
                ),
              ),
              const SizedBox(height: 70, child: CellCodeInput()),
              const SizedBox(height: 8),
              if (_isWrongCode) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                    opacity: 0.6,
                    child: colorText(
                      theme,
                      AppLocalizations.of(context)!.wrongConnectingCode,
                      'red',
                    ),
                  ),
                ),

                // Вывод текста Повторите попытку через 30 секунд
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     AppLocalizations.of(context)!
                //         .tryToRepeatAfter30sec,
                //     style: kMainTextRoboto.copyWith(
                //       fontSize: 14,
                //       color: AppColors.kLightTextColor,
                //     ),
                //   ),
                // ),
              ],
              const SizedBox(height: 96),
            ],
          ),
          Text(
            AppLocalizations.of(context)!.enter_by_qr_code,
            style: theme.textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CellCodeInput extends StatefulWidget {
  const CellCodeInput({Key? key}) : super(key: key);

  @override
  _CellCodeInputState createState() => _CellCodeInputState();
}

class _CellCodeInputState extends State<CellCodeInput> {
  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Курсор, оставил код на случай если дизайнеры решат его всё таки сделать
    //
    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final defaultPinTheme = PinTheme(
        width: 44,
        height: 52,
        textStyle: isWrongCode(state)
            ? theme.textTheme.headline5!.copyWith(color: theme.errorColor)
            : theme.textTheme.headline5,
        decoration: BoxDecoration(
          color: isWrongCode(state) ? theme.hintColor : theme.splashColor,
          borderRadius: BorderRadius.circular(8),
        ),
      );

      return Pinput(
        autofocus: true,
        key: _formKey,
        useNativeKeyboard: true,
        length: 6,
        controller: _codeController,
        focusNode: _codeFocusNode,
        defaultPinTheme: defaultPinTheme,
        separator: const SizedBox(width: 11),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(color: theme.hintColor),
        ),
        focusedPinTheme: PinTheme(
          width: 52,
          height: 62,
          decoration: BoxDecoration(
            color: isWrongCode(state) ? theme.hintColor : theme.splashColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(40, 42, 45, 0.08),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        showCursor: true,
        cursor: cursor,
        onChanged: (value) =>
            context.read<AuthBloc>().add(ChangeAuthCode(value)),
        onCompleted: (value) =>
            context.read<AuthBloc>().add(AuthEventImpl(value)),
      );
    });
  }
}

bool isWrongCode(AuthState state) {
  if (state is ErrorAuthState) {
    return true;
  }

  return false;
}

class GetCodeWidget extends StatelessWidget {
  const GetCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final double contWidth = width * 0.515;
    final double contHeigth = height * 0.643;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) ...[
          const LoaderWebWidget(),
        ] else ...[
          const SizedBox(),
        ],
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: contWidth,
              maxHeight: contHeigth,
              minHeight: contHeigth,
              minWidth: contWidth,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: theme.splashColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: contWidth * 0.52,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .howToGetCodeTitleWeb,
                                style: theme.textTheme.headline3,
                                softWrap: true,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: contWidth * 0.86,
                          child: Text(
                            AppLocalizations.of(context)!.howToGetCodeText,
                            style: theme.textTheme.headline6,
                            softWrap: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: colorText(
                          theme,
                          AppLocalizations.of(context)!.address,
                          'grey',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.addressForCode,
                          style: theme.textTheme.headline6!.copyWith(
                            color: theme.hoverColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: contWidth * 0.52,
                          child: const WorkModeTable(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: colorText(
                          theme,
                          AppLocalizations.of(context)!.getWithYou,
                          'grey',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: contWidth * 0.52,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WhatGetWithYouWeb(
                                iconPath: 'assets/icons/what_get_icon.svg',
                                text: AppLocalizations.of(context)!.passport,
                              ),
                              WhatGetWithYouWeb(
                                iconPath: 'assets/icons/what_get_icon.svg',
                                text: AppLocalizations.of(context)!.pass,
                                color: theme.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: colorText(
                          theme,
                          AppLocalizations.of(context)!.callBeforeCame,
                          'grey',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Container(
                            width: contWidth * 0.52,
                            height: 46,
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '+7 495 487 34 66',
                                  style: theme.textTheme.headline5!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: colorText(
                          theme,
                          '${AppLocalizations.of(context)!.callAfter} 6 ${AppLocalizations.of(context)!.hours}',
                          'red',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}

Text colorText(
  ThemeData theme,
  String text,
  String color,
) {
  return Text(
    text,
    style: theme.textTheme.headline6!.copyWith(
      color: color == 'red'
          ? theme.errorColor.withOpacity(0.6)
          : theme.hoverColor.withOpacity(0.6),
    ),
  );
}
