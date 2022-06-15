import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';

class FavoritesWrap extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  const FavoritesWrap({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
                                     final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


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
