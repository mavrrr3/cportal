import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_info_section.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactProfilePopUp extends StatelessWidget {
  final ProfileEntity user;
  const ContactProfilePopUp({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        Positioned(
          right: 0,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: theme.hoverColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Image & Full Name.
            Align(
              alignment: Alignment.center,
              child: AvatarBox(
                size: 102,
                imgPath: user.photoLink,
                isApiImg: false,
                borderRadius: 24,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${user.firstName} ${user.middleName} ${user.lastName}',
                style: theme.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            //-- Profile info --
            // Post.
            ProfileInfoSection(
              headline: AppLocalizations.of(context)!.position,
              text: user.position.description,
              bottomPadding: 18,
            ),
            const SizedBox(height: 8),

            // Department.
            ProfileInfoSection(
              headline: AppLocalizations.of(context)!.department,
              text: user.position.description,
              bottomPadding: 18,
            ),

            // Office phone.
            ProfileInfoSection(
              headline: AppLocalizations.of(context)!.office_phone,
              text: user.phone.first.number,
              bottomPadding: 18,
            ),
            // Email.
            ProfileInfoSection(
              headline: AppLocalizations.of(context)!.email,
              text: user.email,
              textColor: theme.primaryColor,
              bottomPadding: 18,
            ),

            // Self phone.
            ProfileInfoSection(
              headline: AppLocalizations.of(context)!.self_phone,
              text: '${user.phone[1].suffix} ${user.phone[1].number}',
              bottomPadding: 18,
            ),

            // Birth date.
            ProfileInfoSection(
              headline: AppLocalizations.of(context)!.birth_date,
              text: user.birthday,
              bottomPadding: 18,
            ),

            const SizedBox(height: 32),
            _ActionButton(
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Function() onTap;

  // Кнопка взаимодействия с пользователем [Перейти в Чат].
  const _ActionButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/message.svg',
              width: 24,
              color: theme.brightness == Brightness.light
                  ? theme.splashColor
                  : theme.hoverColor,
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.go_to_chat,
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.brightness == Brightness.light
                    ? theme.splashColor
                    : theme.hoverColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
