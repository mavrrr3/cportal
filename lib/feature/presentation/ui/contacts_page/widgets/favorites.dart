import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';

class FavoritesRow extends StatelessWidget {
  const FavoritesRow({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  final List<ProfileEntity> items;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index != items.length - 1 ? 12 : 16,
          ),
          child: GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: SizedBox(
              height: 48,
              width: 48,
              child: CircleAvatar(
                backgroundImage: NetworkImage(items[index].photoLink),
                backgroundColor: theme.hoverColor.withOpacity(0.38),
              ),
            ),
          ),
        );
      },
    );
  }
}
