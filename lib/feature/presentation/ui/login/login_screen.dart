import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/login_desktop/login_desktop_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/login_mobile/login_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowedBiometricAuth = false;
  final pinController = TextEditingController();
  final pinFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    final authBloc = context.read<AuthBloc>();
    final state = authBloc.state;

    if (state is HasAuthCredentials && state.enabledBiometric != null) {
      authBloc.add(LogInWithBiometrics(AppLocalizations.of(context)!.logInToContinue));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.goNamed(NavigationRouteNames.mainPage);
        } else if (state is HasAuthCredentials && state is! WrongPinCode) {
          pinFocusNode.requestFocus();
          pinController.clear();
        }
      },
      child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
          ? LoginDesktopScreen(pinController: pinController, pinFocusNode: pinFocusNode)
          : LoginMobileScreen(pinController: pinController, pinFocusNode: pinFocusNode),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }
}
