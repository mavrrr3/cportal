import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/random_color_service.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AvatarAndUserInfo extends StatelessWidget {
  final UserEntity user;

  const AvatarAndUserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        ProfileImage(
          fullName: user.name,
          imgLink: user.photoUrl,
          color: RandomColorService.color,
          size: 102,
          borderRadius: 24,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 250,
          child: Text(
            user.name,
            style: theme.textTheme.px17Bold,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          user.contacts.first.contact,
          style: theme.textTheme.px14,
        ),
        const SizedBox(height: 4),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => context.goNamed(
            NavigationRouteNames.userData,
            params: {
              'fid': user.id,
            },
          ),
          child: Text(
            AppLocalizations.of(context)!.watchData,
            style: theme.textTheme.px16Bold.copyWith(
              color: theme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
