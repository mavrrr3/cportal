import 'package:cportal_flutter/feature/domain/entities/menu_button_entity.dart';
import 'package:equatable/equatable.dart';

class NavigationBarState extends Equatable {
  final int currentIndex;
  final bool isActive;
  final List<MenuButtonEntity> menuItems = [
    MenuButtonEntity(
      img: 'assets/icons/navbar/main.svg',
      text: 'Главная',
    ),
    MenuButtonEntity(
      img: 'assets/icons/navbar/news.svg',
      text: 'Новости',
    ),
    MenuButtonEntity(
      img: 'assets/icons/navbar/questions.svg',
      text: 'Вопросы',
    ),
    MenuButtonEntity(
      img: 'assets/icons/navbar/declaration.svg',
      text: 'Документы',
    ),
    MenuButtonEntity(
      img: 'assets/icons/navbar/contacts.svg',
      text: 'Контакты',
    ),
  ];

  NavigationBarState({
    this.currentIndex = 0,
    this.isActive = false,
  });

  @override
  List<Object?> get props => [currentIndex, isActive];
}
