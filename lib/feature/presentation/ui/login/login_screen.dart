import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
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
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TextEditingController pinController;
  late FocusNode pinFocusNode;

  late AnimationController successAnimationController;

  late AnimationController declinedAnimationController;

  @override
  void initState() {
    pinController = TextEditingController();
    pinFocusNode = FocusNode();
    _setUpAnimationControllers();

    pinController.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  bool isShowedBiometricAuth = false;

  @override
  Widget build(BuildContext context) {
    _showBiometricPopup(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is Authenticated) {
          await Future<dynamic>.delayed(const Duration(milliseconds: 900));
          context.goNamed(NavigationRouteNames.mainPage);
        } else if (state is HasAuthCredentials && state is! WrongPinCode) {
          pinController.clear();
        }
      },
      child: ResponsiveWrapper.of(context).isLargerThan(TABLET)
          ? LoginDesktopScreen(
              pinController: pinController,
              pinFocusNode: pinFocusNode,
            )
          : LoginMobileScreen(
              pinController: pinController,
              pinFocusNode: pinFocusNode,
            ),
    );
  }

  void _showBiometricPopup(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final state = authBloc.state;

    if (!isShowedBiometricAuth &&
        state is HasAuthCredentials &&
        state.enabledBiometric != null) {
      isShowedBiometricAuth = true;

      authBloc.add(
        LogInWithBiometrics(
          AppLocalizations.of(context)!.logInToContinue,
        ),
      );
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    successAnimationController.dispose();
    declinedAnimationController.dispose();
    super.dispose();
  }

  void _setUpAnimationControllers() {
    successAnimationController = AnimationController(vsync: this);

    declinedAnimationController = AnimationController(vsync: this);
  }
}
