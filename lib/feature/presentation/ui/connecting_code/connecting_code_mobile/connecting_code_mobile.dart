import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/enter_connecting_code.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ConnectingCodeMobile extends StatelessWidget {
  final TextEditingController codeController;
  final FocusNode codeFocusNode;

  const ConnectingCodeMobile({
    Key? key,
    required this.codeController,
    required this.codeFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return AuthMobileLayout(
      appBarSuffix: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.pushNamed(
          NavigationRouteNames.qrScanner,
          // ignore: avoid_types_on_closure_parameters
          extra: (String scannedData) => context.read<ConnectingCodeBloc>().add(ReadQrCode(scannedData)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            ImageAssets.qrCode,
            color: theme.primary,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 8),
              EnterConnectingCode(
                codeController: codeController,
                codeFocusNode: codeFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
