import 'package:cportal_flutter/app_config.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AvatarBox extends StatelessWidget {
  final double size;
  final String imgPath;
  final Duration duration;
  final bool isAnimation;
  final bool isApiImg;
  final double borderRadius;
  const AvatarBox({
    Key? key,
    required this.size,
    required this.imgPath,
    this.duration = const Duration(milliseconds: 200),
    this.isAnimation = false,
    this.isApiImg = true,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: isAnimation ? duration : const Duration(milliseconds: 300),
      width: isAnimation ? 0 : size,
      height: isAnimation ? 0 : size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          image: ExtendedNetworkImageProvider(
            isApiImg ? '${AppConfig.apiUri}/images/$imgPath' : imgPath,
            cache: true,
          ),
        ),
      ),
    );
  }
}
