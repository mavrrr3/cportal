import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final ProfileEntity user;
  final double size;
  final double borderRadius;
  const ProfileImage({
    Key? key,
    required this.user,
    required this.size,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: user.photoLink != ''
          ? AvatarBox(
              size: size,
              imgPath: user.photoLink,
              borderRadius: borderRadius,
            )
          : _EmptyAvatarBox(
              size: size,
              borderRadius: borderRadius,
              user: user,
            ),
    );
  }
}

class _EmptyAvatarBox extends StatelessWidget {
  final ProfileEntity user;
  final double size;
  final double borderRadius;
  const _EmptyAvatarBox({
    Key? key,
    required this.user,
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
        color: user.color,
      ),
      child: Center(
        child: Text(
          getShortName(user.fullName),
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
