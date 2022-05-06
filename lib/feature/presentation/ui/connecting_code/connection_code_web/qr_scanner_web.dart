import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';

class QrScannerWeb extends StatelessWidget {
  const QrScannerWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isWrongCode = false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LoaderWebWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
              ),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: ((context, state) {
                  if (state is AuthUser) {
                    const String nextScreen = kIsWeb
                        ? NavigationRouteNames.createPinWeb
                        : NavigationRouteNames.createPin;

                    context.goNamed(nextScreen);
                  }
                  if (state is ErrorAuthState) _isWrongCode = !_isWrongCode;
                }),
                builder: ((context, state) {
                  return const BodyWidget();
                }),
              ),
            ),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 260),
        // TODO Реализовать генерацию QR кода
        const Placeholder(
          fallbackHeight: 206,
          fallbackWidth: 206,
        ),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.scan_qr_by_phone,
          style: theme.textTheme.headline1,
        ),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.qr_code_connect_descript,
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 96),
        Text(
          AppLocalizations.of(context)!.enter_by_connecting_code,
          style: theme.textTheme.headline5!.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }
}

class HeaderText {
  static HeaderTextWidget factory(
    PinCodeInputEnum input,
    BuildContext context,
  ) {
    switch (input) {
      case PinCodeInputEnum.create:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.createPinCode,
          secondText: AppLocalizations.of(context)!.itWillBeNeedToEnter,
        );

      case PinCodeInputEnum.repeat:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: ' ',
        );
      case PinCodeInputEnum.edit:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.enterNewPinCode,
          secondText: AppLocalizations.of(context)!.itWillBeNeedToEnter,
        );
      case PinCodeInputEnum.error:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
          error: AppLocalizations.of(context)!.errorPinCode,
        );
      case PinCodeInputEnum.wrong:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: '',
          error: AppLocalizations.of(context)!.pinNotCorrect,
        );
      case PinCodeInputEnum.input:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
        );
      case PinCodeInputEnum.wrongInput:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
          error: AppLocalizations.of(context)!.errorPinCode,
        );
      default:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
        );
    }
  }
}

class HeaderTextWidget extends StatelessWidget {
  final String title;
  final String secondText;
  final String? error;

  const HeaderTextWidget({
    Key? key,
    required this.title,
    required this.secondText,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(height: 31.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  title,
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
            Text(
              secondText,
              style: theme.textTheme.headline6!.copyWith(
                color: secondText ==
                        AppLocalizations.of(context)!.itWillBeNeedToEnter
                    ? theme.hoverColor
                    : theme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 46),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error ?? '',
              style:
                  theme.textTheme.headline6!.copyWith(color: theme.errorColor),
            ),
          ],
        ),
      ],
    );
  }
}
