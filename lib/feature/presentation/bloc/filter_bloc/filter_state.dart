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

class FilterFetchErrorState extends FilterState {
  final String message;

  const FilterFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ContactsFiltersLoadedState extends FilterState {
  final List<FilterEntity> filters;

  /// Стейт для раздела [Контакты].
  const ContactsFiltersLoadedState({
    required this.filters,
  });

  @override
  List<Object?> get props => [filters];
}

class DeclarationsFiltersLoadedState extends FilterState {
  final List<FilterEntity> filters;

  /// Стейт для раздела [Заявления].
  const DeclarationsFiltersLoadedState({
    required this.filters,
  });

  @override
  List<Object?> get props => [filters];
}
