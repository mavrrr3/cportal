import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AvatarAndUserInfo extends StatelessWidget {
  final ProfileEntity profile;

  const AvatarAndUserInfo({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
                             final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    return Center(
      child: Column(
        children: [
          const SizedBox(height: 32),
          AvatarBox(
            size: 102,
            imgPath: profile.photoLink,
            borderRadius: 24,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 250,
            child: Text(
              profile.fullName,
              style: theme.textTheme.px17.copyWith(
                fontWeight: FontWeight.w800,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            profile.contactInfo.first.contact,
            style: theme.textTheme.px16,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => context.goNamed(NavigationRouteNames.userData),
            child: Text(
              AppLocalizations.of(context)!.watchData,
              style: theme.textTheme.px16.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
