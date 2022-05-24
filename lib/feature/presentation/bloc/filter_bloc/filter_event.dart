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

class FilterSelectItemEvent extends FilterEvent {
  final int filterIndex;
  final int itemIndex;
  const FilterSelectItemEvent({
    required this.filterIndex,
    required this.itemIndex,
  });
}
