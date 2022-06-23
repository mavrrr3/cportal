import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

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
      child: const Center(
        child: SvgIcon(
          null,
          path: 'logo.svg',
          width: 120,
        ),
      ),
    );
  }
}
