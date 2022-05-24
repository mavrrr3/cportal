import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
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

  final List<FilterEntity>? filters;

  @override
  List<Object?> get props => [filters];
}
