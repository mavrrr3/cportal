import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';

final _pinController = TextEditingController();
final _pinFocusNode = FocusNode();

class InputPinWeb extends StatelessWidget {
  const InputPinWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PinCodeBloc>(context, listen: false)
        .add(EditPinCodeCheckEvent());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LoaderWebWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: BlocConsumer<PinCodeBloc, PinCodeState>(
                listener: (context, state) {
                  if (state.status == PinCodeInputEnum.done) {
                    // Если ПИН код из базе Hive совпадает с
                    // введеным ПИНом, то редирект на страницу [/main_page]
                    context.goNamed(NavigationRouteNames.mainPage);
                  }
                },
                builder: (context, state) {
                  return BodyWidget(input: state.status);
                },
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
  final PinCodeInputEnum input;
  const BodyWidget({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PinCodeInputEnum _changeBody(PinCodeInputEnum input) {
      switch (input) {
        case PinCodeInputEnum.create:
          return PinCodeInputEnum.input;

        case PinCodeInputEnum.wrongInput:
          return PinCodeInputEnum.wrongInput;
        case PinCodeInputEnum.error:
          return PinCodeInputEnum.error;
        default:
          return PinCodeInputEnum.create;
      }
    }

    return Column(
      children: [
        const SizedBox(height: 260),
        HeaderText.factory(
          _changeBody(input),
          context,
        ),
        const SizedBox(height: 16),
        const PinCodeInput(),
      ],
    );
  }
}

class PinCodeInput extends StatefulWidget {
  const PinCodeInput({
    Key? key,
  }) : super(key: key);

  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  // @override
  // void dispose() {
  //   pinController.dispose();
  //   pinFocusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pinCodeBloc = BlocProvider.of<PinCodeBloc>(context, listen: false);
    final defaultPinTheme = PinTheme(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: theme.hoverColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Pinput(
          autofocus: true,
          obscureText: true,
          obscuringWidget: SvgIcon(
            state.isWrongPin ? theme.errorColor : theme.primaryColor,
            path: 'obscure_symbol.svg',
            width: 16,
          ),
          useNativeKeyboard: true,
          length: 4,
          controller: _pinController,
          focusNode: _pinFocusNode,
          defaultPinTheme: defaultPinTheme,
          separator: const SizedBox(width: 32),
          focusedPinTheme: defaultPinTheme,
          showCursor: false,
          onChanged: (value) {
            pinCodeBloc.add(
              ChangedInputPinCode(
                status: state.status,
                pinCode: value,
              ),
            );
          },
          onCompleted: (value) {
            state.cleanField(_pinController);

            pinCodeBloc.add(
              InputPinCodeSubmit(
                pinCode: value,
                status: state.status,
              ),
            );
          },
        );
      },
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
          error: _pinController.text.length == 4
              ? AppLocalizations.of(context)!.pinNotCorrect
              : '',
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
        const SizedBox(height: 31),
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
        const SizedBox(height: 8),
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
