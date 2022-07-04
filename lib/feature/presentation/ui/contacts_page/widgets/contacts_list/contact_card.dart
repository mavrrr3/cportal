import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';

class ContactCard extends StatelessWidget {
  final ProfileEntity user;
  final double? width;

  /// Карточка контакта.
  const ContactCard({
    Key? key,
    required this.user,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImage(user: user, size: 48, borderRadius: 6),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.px14
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.position,
                      style: theme.textTheme.px12.copyWith(
                        color: theme.textLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TagContainer(text: item.position.department),.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
