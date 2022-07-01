import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DesktopMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;
  final Function()? onboarding;

  const DesktopMenu({
    Key? key,
    required this.currentIndex,
    required this.onChange,
    this.onboarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: 256,
      height: MediaQuery.of(context).size.height,
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: GestureDetector(
                onTap: onboarding,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SvgPicture.asset(
                    ImageAssets.logo,
                    color: theme.text!.withOpacity(0.4),
                    width: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Генерация навигационных элементов меню.
            ...List.generate(
              menuItems.length,
              (index) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onChange(index);
                },
                child: _MenuItem(
                  item: menuItems[index],
                  isActive: currentIndex == index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<MenuButtonModel> menuItems = [
  MenuButtonModel(
    img: 'assets/icons/navbar/main.svg',
    text: 'Главная',
  ),
  MenuButtonModel(
    img: 'assets/icons/navbar/news.svg',
    text: 'Новости',
  ),
  MenuButtonModel(
    img: 'assets/icons/navbar/questions.svg',
    text: 'Вопросы',
  ),
  MenuButtonModel(
    img: 'assets/icons/navbar/declaration.svg',
    text: 'Заявления',
  ),
  MenuButtonModel(
    img: 'assets/icons/navbar/contacts.svg',
    text: 'Контакты',
  ),
];

class MenuButtonModel {
  final String img;
  final String text;

  MenuButtonModel({
    required this.img,
    required this.text,
  });
}

class _MenuItem extends StatelessWidget {
  final MenuButtonModel item;
  final Duration duration = const Duration(milliseconds: 250);
  final bool isActive;

  const _MenuItem({
    Key? key,
    required this.item,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isActive
            ? theme.brightness == Brightness.light
                ? theme.background
                : theme.background?.withOpacity(0.34)
            : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SvgPicture.asset(
              item.img,
              width: 24,
              color: isActive ? theme.primary : theme.text?.withOpacity(0.48),
            ),
            const SizedBox(width: 16),
            Text(
              item.text,
              style: theme.textTheme.px16.copyWith(
                color: isActive ? theme.primary : theme.text,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void changePage(BuildContext context, int index) {
  BlocProvider.of<NavigationBarBloc>(context).add(NavigationBarEventImpl(index: index));

  switch (index) {
    case 0:
      GoRouter.of(context).pushNamed(NavigationRouteNames.mainPage);
      break;
    case 1:
      GoRouter.of(context).pushNamed(NavigationRouteNames.news);
      break;
    case 2:
      GoRouter.of(context).pushNamed(NavigationRouteNames.questions);
      break;
    case 3:
      GoRouter.of(context).pushNamed(NavigationRouteNames.declarations);
      break;
    case 4:
      GoRouter.of(context).pushNamed(NavigationRouteNames.contacts);
      break;
    default:
      GoRouter.of(context).pushNamed(NavigationRouteNames.mainPage);
  }
}
