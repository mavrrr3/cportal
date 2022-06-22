import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Favorites extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  const Favorites({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return !ResponsiveWrapper.of(context).isLargerThan(TABLET)
        ? SizedBox(
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
          )
        : Wrap(
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
