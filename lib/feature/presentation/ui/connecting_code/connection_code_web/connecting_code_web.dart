import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _codeController = TextEditingController();

final _codeFocusNode = FocusNode();

final _formKey = GlobalKey<FormState>();
bool _isWrongCode = false;

class ConnectingCodeWeb extends StatelessWidget {
  const ConnectingCodeWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LoaderWebWidget(),
        BlocListener<AuthBloc, AuthState>(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 260),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.inputConnectingCode,
                          style: theme.textTheme.headline2,
                        ),
                        const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _showHowToGetCOnnectingCode(context),
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
                    const CellCodeInput(),
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppLocalizations.of(context)!.enter_by_qr_code,
                        style: theme.textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(),
      ],
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
        // errorBuilder: ,
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

Future<void> _showHowToGetCOnnectingCode(BuildContext context) {
  bool _isShow = false;

  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final ThemeData theme = Theme.of(context);

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
            backgroundColor: theme.splashColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.howToGetCodeTitle,
                      style: theme.textTheme.headline3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.howToGetCodeText,
                    style: theme.textTheme.headline6,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      colorText(
                        theme,
                        AppLocalizations.of(context)!.workMode,
                        'grey',
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isShow = !_isShow;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 26,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isShow,
                    child: const WorkModeTable(),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      theme,
                      AppLocalizations.of(context)!.getWithYou,
                      'grey',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WhatGetWithYou(
                        iconPath: 'assets/icons/what_get_icon.svg',
                        text: AppLocalizations.of(context)!.passport,
                      ),
                      WhatGetWithYou(
                        iconPath: 'assets/icons/what_get_icon.svg',
                        text: AppLocalizations.of(context)!.pass,
                        color: theme.primaryColor,
                      ),
                    ],
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
                  phoneButton(theme),
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
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    primary: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.close,
                    style: theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.splashColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget phoneButton(ThemeData theme) {
  return Container(
    width: double.infinity,
    height: 46,
    decoration: BoxDecoration(
      color: theme.backgroundColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.phone,
          size: 26,
          color: theme.hoverColor,
        ),
        Text(
          '+7 495 487 34 66',
          style:
              theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 40),
      ],
    ),
  );
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
