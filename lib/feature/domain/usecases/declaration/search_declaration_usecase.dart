import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class SearchDeclarationUseCase
    extends IUseCase<List<DeclarationCardEntity>, SearchDeclarationsParams> {
  final IDeclarationRepository repository;

  SearchDeclarationUseCase(this.repository);

  @override
  Future<Either<Failure, List<DeclarationCardEntity>>> call(
    SearchDeclarationsParams params,
  ) async =>
      repository.searchDeclarations(params.query);
}

class SearchDeclarationsParams extends Equatable {
  final String query;

  const SearchDeclarationsParams({required this.query});
  @override
  List<Object?> get props => [query];
}
