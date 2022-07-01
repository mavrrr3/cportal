import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/favorites/favorites_wide_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/favorites/favorites_narrow_screen.dart';

class Favorites extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  /// Рендеринг избранных.
  const Favorites({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return !ResponsiveWrapper.of(context).isLargerThan(TABLET)
        ? FavoritesNarrowScreen(items: items, onTap: onTap, theme: theme)
        : FavoritesWideScreen(items: items, onTap: onTap, theme: theme);
  }
}
