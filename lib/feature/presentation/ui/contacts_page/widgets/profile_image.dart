import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String fullName;
  final String imgLink;
  final Color color;
  final double size;
  final double borderRadius;
  const ProfileImage({
    Key? key,
    required this.fullName,
    required this.imgLink,
    required this.color,
    required this.size,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: imgLink != ''
          ? AvatarBox(
              size: size,
              imgPath: imgLink,
              borderRadius: borderRadius,
            )
          : _EmptyAvatarBox(
              fullName: fullName,
              size: size,
              borderRadius: borderRadius,
              color: color,
            ),
    );
  }
}

class _EmptyAvatarBox extends StatelessWidget {
  final String fullName;
  final Color color;
  final double size;
  final double borderRadius;
  const _EmptyAvatarBox({
    Key? key,
    required this.fullName,
    required this.color,
    this.size = 48,
    this.borderRadius = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: Center(
        child: Text(
          getShortName(fullName),
          style: theme.textTheme.px22.copyWith(
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}

String getShortName(String name) {
  final nameList = name.split(' ');

  return '${nameList.first[0]} ${nameList[1][0]}';
}
