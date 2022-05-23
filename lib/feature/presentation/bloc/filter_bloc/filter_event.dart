import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterInitEvent extends FilterEvent {}

class FilterExpandSectionEvent extends FilterEvent {
  final int index;
  const FilterExpandSectionEvent({required this.index});
}
