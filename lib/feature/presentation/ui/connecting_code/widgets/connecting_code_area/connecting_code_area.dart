import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/connecting_code_area/connecting_code_input.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/connecting_code_area/cursor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingCodeArea extends StatelessWidget {
  final TextEditingController codeController;
  final bool isWrongCode;
  final bool isDesktop;

  const ConnectingCodeArea({
    Key? key,
    required this.codeController,
    required this.isWrongCode,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

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
            isDesktop ? NavigationRouteNames.connectingCodeInfo : NavigationRouteNames.connectingCodeInfoPopup,
          ),
          child: Text(
            AppLocalizations.of(context)!.howToGetConnectingCode,
            style: theme.textTheme.px14.copyWith(
              color: theme.primary,
            ),
          ),
        ),
        const SizedBox(height: 27),
        SizedBox(
          height: 62,
          width: 340,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConnectingCodeInput(
              useNativeKeyboard: isDesktop,
              codeController: codeController,
              cursor: isDesktop ? const Cursor() : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (isWrongCode) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Opacity(
              opacity: 0.6,
              child: Text(
                AppLocalizations.of(context)!.wrongConnectingCode,
                style: theme.textTheme.px14.copyWith(color: theme.red?.withOpacity(0.6)),
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
    );
  }
}
