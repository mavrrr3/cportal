import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// TODO: Need to create layout for desktop screen with burger menu.
class QuestionLayout extends StatelessWidget {
  final Widget child;

  const QuestionLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLargerThenTablet(context)
        ? QuestionDesktopLayout(child: child)
        : LayoutWithAppBar(
            title: '',
            onTapBackButton: () => context.goNamed(NavigationRouteNames.questions),
            child: SingleChildScrollView(child: child),
          );
  }
}

class QuestionDesktopLayout extends StatelessWidget {
  final Widget child;

  const QuestionDesktopLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesktopMenu(
            currentIndex: 2,
            onChange: (index) => MenuService.changePage(context, index),
          ),
          const SizedBox(width: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SafeArea(
              bottom: false,
              child: CustomScrollView(
                slivers: [
                  const SliverPersistentHeader(delegate: QuestionDesktopDelegate(), pinned: true),
                  SliverToBoxAdapter(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionDesktopDelegate extends SliverPersistentHeaderDelegate {
  const QuestionDesktopDelegate();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      color: theme.background,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.goNamed(NavigationRouteNames.questions),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ImageAssets.backArrow,
              color: theme.primary,
            ),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.questions,
                style: theme.textTheme.px16Bold.copyWith(color: theme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
