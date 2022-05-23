import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:equatable/equatable.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

class FilterStateImpl extends FilterState {
  const FilterStateImpl({
    this.filters,
  });

  final List<FilterModel>? filters;

  @override
  List<Object?> get props => [filters];
}
