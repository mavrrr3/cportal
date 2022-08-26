import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchDeclarationsUseCase
    extends IUseCase<List<DeclarationEntity>, FetchDeclarationsParams> {
  final IDeclarationRepository repository;

  FetchDeclarationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DeclarationEntity>>> call(
    FetchDeclarationsParams params,
  ) async =>
      repository.fetchDeclarations(params.page);
}

class FetchDeclarationsParams extends Equatable {
  final int page;

  const FetchDeclarationsParams({required this.page});
  @override
  List<Object?> get props => [page];
}
