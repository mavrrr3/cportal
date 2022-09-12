import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';

class UserCard extends StatelessWidget {
  final String fullName;
  final String position;
  final String imgLink;
  final Color color;

  final double? width;

  /// Карточка контакта.
  const UserCard({
    Key? key,
    required this.fullName,
    required this.position,
    required this.imgLink,
    required this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.6 : 1,
          child: GestureDetector(
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
                    ProfileImage(
                      fullName: fullName,
                      imgLink: imgLink,
                      color: color,
                      size: 48,
                      borderRadius: 6,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.px14.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.143,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),  
                          ),
                          const SizedBox(height: 4),
                          Text(
                            position,
                            maxLines: 1,
                            style: theme.textTheme.px12.copyWith(
                              color: theme.textLight,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
