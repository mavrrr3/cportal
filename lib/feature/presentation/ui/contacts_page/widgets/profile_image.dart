import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final ProfileEntity user;
  const ProfileImage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: user.photoLink != ''
          ? AvatarBox(
              size: 102,
              imgPath: user.photoLink,
              borderRadius: 24,
            )
          : EmptyAvatarBox(
              size: 102,
              borderRadius: 24,
              user: user,
            ),
    );
  }
}
