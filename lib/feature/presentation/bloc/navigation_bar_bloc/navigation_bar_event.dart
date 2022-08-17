import 'package:equatable/equatable.dart';

abstract class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();

  @override
  List<Object> get props => [];
}

class NavBarChangePageEvent extends NavigationBarEvent {
  final int index;
  const NavBarChangePageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class NavBarVisibilityEvent extends NavigationBarEvent {
  final bool isActive;
  const NavBarVisibilityEvent({required this.isActive});

  @override
  List<Object> get props => [isActive];
}
