import 'package:cportal_flutter/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:cportal_flutter/presentation/ui/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authinticated) {
          Navigator.of(context).pushNamed('/main_page');
        } else if (state is UnAuthinticated) {
          Navigator.of(context).pushNamed('/connecting_code');
        }
      },
      child: Container(
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
      ),
    );
  }
}
