import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DeclarationsState extends Equatable {
  const DeclarationsState();

  @override
  List<Object?> get props => [];
}

class DeclarationsEmptyState extends DeclarationsState {}

class DeclarationsLoadingState extends DeclarationsState {
  final List<DeclarationCardEntity> oldDeclarations;
  final DateTime lastRenderedDate;
  final bool isFirstFetch;

  const DeclarationsLoadingState({
    required this.oldDeclarations,
    required this.lastRenderedDate,
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldDeclarations, isFirstFetch];
}

class DeclarationsLoadedState extends DeclarationsState {
  final List<DeclarationCardEntity> declarations;
  final DateTime lastRenderedDate;

  const DeclarationsLoadedState({
    required this.declarations,
    required this.lastRenderedDate,
  });

  @override
  List<Object?> get props => [declarations];
}

class DeclarationsFetchErrorState extends DeclarationsState {
  final String message;

  const DeclarationsFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
