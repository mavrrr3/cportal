import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/connecting_code_area/connecting_code_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/splash_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingCodeWeb extends StatefulWidget {
  final TextEditingController codeController;

  const ConnectingCodeWeb({
    Key? key,
    required this.codeController,
  }) : super(key: key);

  @override
  State<ConnectingCodeWeb> createState() => _ConnectingCodeWebState();
}

class _ConnectingCodeWebState extends State<ConnectingCodeWeb> {
  bool _isWrongCode = false;

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUser) {
          const String nextScreen = kIsWeb ? NavigationRouteNames.createPinWeb : NavigationRouteNames.createPin;

          context.goNamed(nextScreen);
        }
        if (state is ErrorAuthState) _isWrongCode = !_isWrongCode;
      },
      child: Row(
        children: [
          const SplashWidget.desktop(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 260),
                ConnectingCodeArea(
                  codeController: widget.codeController,
                  isWrongCode: _isWrongCode,
                  isDesktop: true,
                ),
                const SizedBox(height: 96),
                GestureDetector(
                  onTap: () => context.pushNamed(NavigationRouteNames.connectingQr),
                  child: Text(
                    AppLocalizations.of(context)!.enter_by_qr_code,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
