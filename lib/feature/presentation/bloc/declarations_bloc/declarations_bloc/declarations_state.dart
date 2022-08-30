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
  final bool isFirstFetch;

  const DeclarationsLoadingState(
    this.oldDeclarations, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldDeclarations, isFirstFetch];
}

class DeclarationsLoadedState extends DeclarationsState {
  final List<DeclarationCardEntity> declarations;

  const DeclarationsLoadedState({
    required this.declarations,
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
