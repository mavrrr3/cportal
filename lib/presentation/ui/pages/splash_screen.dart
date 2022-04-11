import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/presentation/go_navigation.dart';
import 'package:cportal_flutter/presentation/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'splashScreen';
  static Route<SplashScreen> route() {
    return MaterialPageRoute<SplashScreen>(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context, listen: false).add(const CheckAuth());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          final nextScreen = state.isAuth
              ? NavigationRouteNames.mainPage
              : NavigationRouteNames.connectingCode;

          context.goNamed(nextScreen);
        }
      },
      child: const LoaderWidget(),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/bg_splash.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(37, 39, 40, 0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgIcon(null, path: 'logo.svg', width: 120.w),
          ),
        ],
      ),
    );
  }
}
