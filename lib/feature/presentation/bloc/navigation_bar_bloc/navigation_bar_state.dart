import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';

class NavBarState {
  final int currentIndex;
  // TODO: Вынести в файл с константами
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
      text: 'Заявки',
    ),
    MenuButtonModel(
      img: 'assets/icons/navbar/contacts.svg',
      text: 'Контакты',
    ),
  ];

  NavBarState({
    this.currentIndex = 0,
  });
}
