import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const CheckLogin());
    // _fetchContent();.
    super.initState();
  }

  // void _fetchContent() {
  //   context
  //     ..read<FetchNewsBloc>().add(const FetchAllNewsEvent())
  //     ..read<FetchQuestionsBloc>().add(const FetchQuestionsEvent());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final nextScreen =
              state is HasAuthCredentials ? NavigationRouteNames.login : NavigationRouteNames.connectingCode;

          context.goNamed(nextScreen);
        },
        child: const SplashWidget.mobile(),
      ),
    );
  }
}
