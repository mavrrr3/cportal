import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return isMobile(context)
        ? LayoutWithAppBar(
            title: '',
            onTapBackButton: () =>
                context.goNamed(NavigationRouteNames.questions),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: child,
            ),
          )
        : QuestionWebTabletLayout(child: child);
  }
}

class QuestionWebTabletLayout extends StatelessWidget {
  final Widget child;

  const QuestionWebTabletLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final customPadding = ResponsiveUtil(context);

    return Scaffold(
      backgroundColor: theme.background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!zeroWidthCondition(context)) ...[
            DesktopMenu(
              currentIndex: 2,
              onChange: (index) => MenuService.changePage(context, index),
            ),
            const SizedBox(width: 7),
          ],
          SafeArea(
            bottom: false,
            child: SizedBox(
              width: customPadding.widthContent(),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverPersistentHeader(
                      delegate: QuestionDesktopDelegate(), pinned: true),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final width = MediaQuery.of(context).size.width;
    final customPadding = ResponsiveUtil(context);

    return Container(
      padding: width < 514
          ? const EdgeInsets.only(left: 16, top: 20)
          : zeroWidthCondition(context)
              ? const EdgeInsets.only(left: 40, top: 20)
              : EdgeInsets.only(
                  left: customPadding.webTabletPadding().horizontal / 2,
                  top: 20,
                ),
      color: theme.background,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.goNamed(NavigationRouteNames.questions),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (zeroWidthCondition(context) && width > 514) ...[
              BurgerMenuButton(onTap: () {
                context
                    .read<NavigationBarBloc>()
                    .add(const NavBarVisibilityEvent(
                      index: 1,
                      isActive: true,
                    ));
              }),
            ],
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
