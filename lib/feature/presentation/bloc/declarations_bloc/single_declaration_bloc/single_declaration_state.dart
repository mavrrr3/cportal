import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SingleDeclarationState extends Equatable {
  const SingleDeclarationState();

  @override
  List<Object?> get props => [];
}

class SingleDeclarationEmptyState extends SingleDeclarationState {}

class SingleDeclarationLoadingState extends SingleDeclarationState {}

class SingleDeclarationLoadedState extends SingleDeclarationState {
  final DeclarationInfoEntity declaration;

  const SingleDeclarationLoadedState({
    required this.declaration,
  });

  @override
  List<Object?> get props => [declaration];
}

class SingleDeclarationFetchErrorState extends SingleDeclarationState {
  final String message;

  const SingleDeclarationFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
