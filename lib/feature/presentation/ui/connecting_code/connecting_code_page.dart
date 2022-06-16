import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
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

class ConnectingCodePage extends StatelessWidget {
  const ConnectingCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

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
      child: Scaffold(
        backgroundColor: theme.background,
        body: Column(
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
                    children: [
                      SvgIcon(
                        theme.brightness == Brightness.dark
                            ? theme.textLight
                            : null,
                        path: 'logo_grey.svg',
                        width: 24,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => GoRouter.of(context)
                            .pushNamed(NavigationRouteNames.qrScanner),
                        child: SvgIcon(
                          theme.primary,
                          path: 'qr_code.svg',
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 31),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.inputConnectingCode,
                            style: theme.textTheme.header,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _showHowToGetCOnnectingCode(context),
                        child: Text(
                          AppLocalizations.of(context)!.howToGetConnectingCode,
                          style: theme.textTheme.px14.copyWith(
                            color: theme.primary,
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
                    //       fontSize: 14.sp,
                    //       color: AppColors.kLightTextColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ],
              ),
            ),
            Column(
              children: [
                CustomKeyboard(
                  controller: _codeController,
                  simbolQuantity: 6,
                ),
                const SizedBox(height: 52),
              ],
            ),
          ],
        ),
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    // Курсор, оставил код на случай если дизайнеры решат его всё таки сделать
    //
    // final cursor = Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Container(
    //     width: 21,
    //     height: 1,
    //     margin: const EdgeInsets.only(bottom: 12),
    //     decoration: BoxDecoration(
    //       color: const Color.fromRGBO(137, 146, 160, 1),
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // );

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final defaultPinTheme = PinTheme(
        width: 44,
        height: 52,
        textStyle: isWrongCode(state)
            ? theme.textTheme.px16.copyWith(color: theme.red)
            : theme.textTheme.px16,
        decoration: BoxDecoration(
          color: isWrongCode(state) ? theme.lightRedPIN : theme.cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
      );

      return Pinput(
        key: _formKey,
        useNativeKeyboard: false,
        length: 6,
        controller: _codeController,
        focusNode: _codeFocusNode,
        defaultPinTheme: defaultPinTheme,
        separator: const SizedBox(width: 11),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(color: theme.lightRedPIN),
        ),
        focusedPinTheme: PinTheme(
          width: 52,
          height: 62,
          decoration: BoxDecoration(
            color: isWrongCode(state) ? theme.lightRedPIN : theme.cardColor,
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
        showCursor: false,
        // ignore: format-comment
        // cursor: cursor,
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
  bool isShow = false;

  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (context) {
      final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
            backgroundColor: theme.cardColor,
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
                      style: theme.textTheme.px22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.howToGetCodeText,
                    style: theme.textTheme.px14,
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
                      style: theme.textTheme.px14.copyWith(
                        color: theme.textLight,
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
                            isShow = !isShow;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 26,
                          color: theme.primary,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isShow,
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
                        color: theme.primary,
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
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    primary: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.close,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.cardColor,
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

Widget phoneButton(CustomTheme theme) {
  return Container(
    width: double.infinity,
    height: 46,
    decoration: BoxDecoration(
      color: theme.background,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.phone,
          size: 26,
          color: theme.textLight,
        ),
        Text(
          '+7 495 487 34 66',
          style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 40),
      ],
    ),
  );
}

Text colorText(
  CustomTheme theme,
  String text,
  String color,
) {
  return Text(
    text,
    style: theme.textTheme.px14.copyWith(
      color: color == 'red'
          ? theme.red?.withOpacity(0.6)
          : theme.text?.withOpacity(0.6),
    ),
  );
}
