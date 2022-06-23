import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/connecting_code_area/connecting_code_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/custom_keyboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConnectingCodeMobile extends StatefulWidget {
  final TextEditingController codeController;

  const ConnectingCodeMobile({Key? key, required this.codeController}) : super(key: key);

  @override
  State<ConnectingCodeMobile> createState() => _ConnectingCodeMobileState();
}

class _ConnectingCodeMobileState extends State<ConnectingCodeMobile> {
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
        if (state is ErrorAuthState) {
          setState(() {
            _isWrongCode = !_isWrongCode;
          });
        }
      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgIcon(
                        theme.brightness == Brightness.dark ? theme.textLight : null,
                        path: 'logo_grey.svg',
                        width: 24,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => context.pushNamed(NavigationRouteNames.qrScanner),
                        child: SvgIcon(
                          theme.primary,
                          path: 'qr_code.svg',
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 31),
                  ConnectingCodeArea(
                    codeController: widget.codeController,
                    isWrongCode: _isWrongCode,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomKeyboard(
              controller: widget.codeController,
              simbolQuantity: 6,
            ),
            const SizedBox(height: 52),
          ],
        ),
      ),
    );
  }
}
