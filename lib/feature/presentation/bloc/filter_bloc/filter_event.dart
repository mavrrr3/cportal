import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FetchFiltersEvent extends FilterEvent {}

class FilterExpandSectionEvent extends FilterEvent {
  final int index;

  const FilterExpandSectionEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class FilterSelectItemEvent extends FilterEvent {
  final int filterIndex;
  final int itemIndex;

  const FilterSelectItemEvent({
    required this.filterIndex,
    required this.itemIndex,
  });
  @override
  List<Object> get props => [filterIndex, itemIndex];
}

class FilterRemoveItemEvent extends FilterEvent {
  final int filterIndex;
  final FilterItemEntity item;

  const FilterRemoveItemEvent({
    required this.filterIndex,
    required this.item,
  });
  @override
  List<Object> get props => [filterIndex, item];
}

class FilterRemoveAllEvent extends FilterEvent {}

class FilterChangeVisibilityEvent extends FilterEvent {
  final bool isActive;

  const FilterChangeVisibilityEvent({
    required this.isActive,
  });
  @override
  List<Object> get props => [isActive];
}
