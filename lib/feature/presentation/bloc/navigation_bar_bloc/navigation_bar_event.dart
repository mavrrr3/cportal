import 'package:equatable/equatable.dart';

abstract class NavBarEvent extends Equatable {
  const NavBarEvent();

  @override
  List<Object> get props => [];
}

class NavBarEventImpl extends NavBarEvent {
  final int index;
  const NavBarEventImpl({required this.index});
}
