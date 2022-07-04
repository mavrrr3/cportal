import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashWidget extends StatelessWidget {
  final bool isDesktop;

  const SplashWidget.mobile({Key? key, this.isDesktop = false}) : super(key: key);

  const SplashWidget.desktop({Key? key, this.isDesktop = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDesktop ? MediaQuery.of(context).size.width * 0.42 : null,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.splash),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(37, 39, 40, 0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(ImageAssets.logo),
      ),
    );
  }
}
