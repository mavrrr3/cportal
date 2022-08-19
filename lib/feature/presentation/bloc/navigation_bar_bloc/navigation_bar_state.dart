import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/feature/domain/entities/menu_button_entity.dart';
import 'package:equatable/equatable.dart';

class NavigationBarState extends Equatable {
  final int currentIndex;
  final bool isActive;

  final List<MenuButtonEntity> menuItems = [
    MenuButtonEntity(
      img: ImageAssets.mainPage,
      text: 'Главная',
    ),
    MenuButtonEntity(
      img: ImageAssets.newsPage,
      text: 'Новости',
    ),
    MenuButtonEntity(
      img: ImageAssets.questionsPage,
      text: 'Вопросы',
    ),
    MenuButtonEntity(
      img: ImageAssets.declarationPage,
      text: 'Заявления',
    ),
    MenuButtonEntity(
      img: ImageAssets.contactsPage,
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
