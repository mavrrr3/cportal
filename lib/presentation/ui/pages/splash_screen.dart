import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
            child: Logo(width: 120.w),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final double width;
  const Logo({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/logo.svg',
      width: width,
    );
  }
}
