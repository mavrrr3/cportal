import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_mobile/connecting_code_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/connecting_code_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ConnectingCodeScreen extends StatefulWidget {
  const ConnectingCodeScreen({Key? key}) : super(key: key);

  @override
  State<ConnectingCodeScreen> createState() => _ConnectingCodeScreenState();
}

class _ConnectingCodeScreenState extends State<ConnectingCodeScreen> {
  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectingCodeBloc, ConnectingCodeState>(
      listener: (context, state) {
        if (state is AuthenticatedWithConnectingCode) {
          context.goNamed(NavigationRouteNames.createPin);
        }
      },
      child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
          ? ConnectingCodeWeb(
              codeController: codeController,
              codeFocusNode: codeFocusNode,
            )
          : ConnectingCodeMobile(
              codeController: codeController,
              codeFocusNode: codeFocusNode,
            ),
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    codeFocusNode.dispose();
    super.dispose();
  }
}
