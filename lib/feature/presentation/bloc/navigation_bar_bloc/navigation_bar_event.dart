import 'package:equatable/equatable.dart';

abstract class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();

  @override
  List<Object> get props => [];
}

class NavigationBarEventImpl extends NavigationBarEvent {
  final int index;
  const NavigationBarEventImpl({required this.index});
}
