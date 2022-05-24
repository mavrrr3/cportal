import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
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

class FilterRemoveItemEvent extends FilterEvent {
  final int filterIndex;
  final FilterItemModel item;

  const FilterRemoveItemEvent({
    required this.filterIndex,
    required this.item,
  });
}
