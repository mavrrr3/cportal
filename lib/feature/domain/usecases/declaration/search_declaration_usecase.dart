import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class SearchDeclarationUseCase
    extends IUseCase<List<DeclarationEntity>, SearchDeclarationesParams> {
  final IDeclarationRepository repository;

  SearchDeclarationUseCase(this.repository);

  @override
  Future<Either<Failure, List<DeclarationEntity>>> call(
    SearchDeclarationesParams params,
  ) async =>
      repository.searchDeclarations(params.query);
}

class SearchDeclarationesParams extends Equatable {
  final String query;

  const SearchDeclarationesParams({required this.query});
  @override
  List<Object?> get props => [query];
}
