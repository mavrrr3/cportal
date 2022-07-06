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
  void initState() {
    codeController.addListener(() {
      if (codeController.text.length == 6) {
        context.read<ConnectingCodeBloc>().add(LogInWithConnectingCode(codeController.text));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectingCodeBloc, ConnectingCodeState>(
      listener: (context, state) {
        if (state is AuthenticatedWithConnectingCode) {
          codeFocusNode.unfocus();
          context.goNamed(NavigationRouteNames.createPin);
        } else if (state is ConnectingCodeQrReadSuccess) {
          codeController.text = state.connectingCode;
          context.read<ConnectingCodeBloc>().add(LogInWithConnectingCode(state.connectingCode));
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
