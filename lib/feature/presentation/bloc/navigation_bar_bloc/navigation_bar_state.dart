import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';

class NavigationBarState {
  final int currentIndex;
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

  NavigationBarState({
    this.currentIndex = 0,
  });
}
