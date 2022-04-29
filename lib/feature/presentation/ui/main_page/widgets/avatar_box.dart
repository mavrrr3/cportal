import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarBox extends StatelessWidget {
  final double size;
  final String imgPath;
  final Duration duration;
  final bool isAnimation;
  const AvatarBox({
    Key? key,
    required this.size,
    required this.imgPath,
    this.duration = const Duration(milliseconds: 200),
    this.isAnimation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: isAnimation ? duration : const Duration(milliseconds: 300),
      width: isAnimation ? 0 : size,
      height: isAnimation ? 0 : size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
          image: ExtendedNetworkImageProvider(
            imgPath,
            cache: true,
          ),
        ),
      ),
    );
  }
}
