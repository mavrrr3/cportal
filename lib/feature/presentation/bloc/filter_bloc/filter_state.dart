import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

class FilterEmptyState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadingErrorState extends FilterState {
  final String message;
  const FilterLoadingErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class FilterLoadedState extends FilterState {
  final List<FilterEntity> contactsFilters;
  final List<FilterEntity> declarationsFilters;

  const FilterLoadedState({
    this.contactsFilters = const [],
    this.declarationsFilters = const [],
  });

  FilterLoadedState copyWith({
    List<FilterEntity>? contactsFilters,
    List<FilterEntity>? declarationsFilters,
  }) {
    return FilterLoadedState(
      contactsFilters: contactsFilters ?? this.contactsFilters,
      declarationsFilters: declarationsFilters ?? this.declarationsFilters,
    );
  }

  @override
  List<Object?> get props => [
        contactsFilters,
        declarationsFilters,
      ];
}

class FilterVisibilityState extends FilterState {
  final bool isActive;
  const FilterVisibilityState({
    required this.isActive,
  });
  @override
  List<Object?> get props => [
        isActive,
      ];
}
