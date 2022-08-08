import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';

class FavoritesWideScreen extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;
  final CustomTheme theme;

  /// Избранные для широких скринов.
  const FavoritesWideScreen({
    Key? key,
    required this.items,
    required this.onTap,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(
        items.length,
        (i) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            onTap(i);
          },
          child: SizedBox(
            height: 48,
            width: 48,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                items[i].photoLink,
              ),
              backgroundColor: theme.text?.withOpacity(0.38),
            ),
          ),
        ),
      ),
    );
  }
}
