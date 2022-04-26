import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/what_get_with_you.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final ThemeData theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUser) {
          context.goNamed(NavigationRouteNames.createPin);
        }
        if (state is ErrorAuthState) _isWrongCode = !_isWrongCode;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0.w,
            ),
            child: Column(
              children: [
                SizedBox(height: 48.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgIcon(
                      null,
                      path: 'logo_grey.svg',
                      width: 24.0.w,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => GoRouter.of(context)
                          .pushNamed(NavigationRouteNames.qrScanner),
                      child: SvgIcon(null, path: 'qr_code.svg', width: 24.0.w),
                    ),
                  ],
                ),
                SizedBox(height: 31.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.inputConnectingCode,
                          style: theme.textTheme.headline2,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _showHowToGetCOnnectingCode(context),
                      child: Text(
                        AppLocalizations.of(context)!.howToGetConnectingCode,
                        style: theme.textTheme.headline6!.copyWith(
                          color: theme.brightness == Brightness.light
                              ? const Color(0xFF355A99)
                              : const Color(0xFF365A99),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 27.h),
                const CellCodeInput(),
                SizedBox(height: 8.h),
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
              SizedBox(height: 52.h),
            ],
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
        width: 44.w,
        height: 52.h,
        textStyle: isWrongCode(state)
            ? theme.textTheme.headline5!.copyWith(color: theme.errorColor)
            : theme.textTheme.headline5,
        decoration: BoxDecoration(
          color: isWrongCode(state) ? theme.hintColor : theme.splashColor,
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
        separator: SizedBox(width: 11.w),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(color: theme.hintColor),
        ),
        // errorBuilder: ,
        focusedPinTheme: PinTheme(
          width: 52.w,
          height: 62.h,
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
        showCursor: false,
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
            contentPadding: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 28.0.h),
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
                  SizedBox(
                    height: 8.sp,
                  ),
                  Text(
                    AppLocalizations.of(context)!.howToGetCodeText,
                    style: theme.textTheme.headline6,
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      theme,
                      AppLocalizations.of(context)!.address,
                      'grey',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.addressForCode,
                      style: theme.textTheme.headline6!.copyWith(
                        color: theme.hoverColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.w),
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
                          size: 26.sp,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isShow,
                    child: const WorkModeTable(),
                  ),
                  SizedBox(height: 10.w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      theme,
                      AppLocalizations.of(context)!.getWithYou,
                      'grey',
                    ),
                  ),
                  SizedBox(height: 10.h),
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
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      theme,
                      AppLocalizations.of(context)!.callBeforeCame,
                      'grey',
                    ),
                  ),
                  SizedBox(height: 8.h),
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
                    EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 8.0.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
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
    height: 46.h,
    decoration: BoxDecoration(
      color: theme.backgroundColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.phone,
          size: 26.sp,
          color: theme.hoverColor,
        ),
        Text(
          '+7 495 487 34 66',
          style:
              theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 40.w,
        ),
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
