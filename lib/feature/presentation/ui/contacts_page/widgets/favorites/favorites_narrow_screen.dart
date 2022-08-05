import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';

class FavoritesNarrowScreen extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;
  final CustomTheme theme;

  /// Избранные для узких скринов.
  const FavoritesNarrowScreen({
    Key? key,
    required this.items,
    required this.onTap,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(
              right: i != items.length - 1 ? 12 : 16,
            ),
            child: GestureDetector(
              onTap: () {
                onTap(i);
              },
              child: SizedBox(
                height: 48,
                width: 48,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(items[i].photoLink),
                  backgroundColor: theme.text?.withOpacity(0.38),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
