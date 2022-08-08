import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/enter_connecting_code.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_desktop_layout.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingCodeWeb extends StatelessWidget {
  final TextEditingController codeController;
  final FocusNode codeFocusNode;

  const ConnectingCodeWeb({
    Key? key,
    required this.codeController,
    required this.codeFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return AuthDesktopLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 260),
          EnterConnectingCode(
            codeController: codeController,
            codeFocusNode: codeFocusNode,
            isDesktop: true,
          ),
          const SizedBox(height: 96),
          GestureDetector(
            onTap: () => context.pushNamed(NavigationRouteNames.connectingQr),
            child: OnHover(
              builder: (isHovered) {
                return Text(
                  AppLocalizations.of(context)!.enter_by_qr_code,
                  style: theme.textTheme.px16.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isHovered
                        ? theme.primary?.withOpacity(0.6)
                        : theme.primary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
