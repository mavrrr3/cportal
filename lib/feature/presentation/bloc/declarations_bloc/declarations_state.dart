import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DeclarationsState extends Equatable {
  const DeclarationsState();

  @override
  List<Object?> get props => [];
}

class DeclarationsEmptyState extends DeclarationsState {}

class DeclarationsLoadingState extends DeclarationsState {}

class DeclarationsLoadedState extends DeclarationsState {
  final List<DeclarationEntity> doneDeclarations;
  final List<DeclarationEntity> inProgressDeclarations;

  const DeclarationsLoadedState({
    required this.doneDeclarations,
    required this.inProgressDeclarations,
  });

  @override
  List<Object?> get props => [
        doneDeclarations,
        inProgressDeclarations,
      ];
}

class DeclarationsFetchErrorState extends DeclarationsState {
  final String message;

  const DeclarationsFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
