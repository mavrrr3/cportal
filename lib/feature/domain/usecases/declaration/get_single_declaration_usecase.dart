import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class GetSingleDeclarationUseCase
    extends IUseCase<DeclarationInfoEntity, GetSingleDeclarationParams> {
  final IDeclarationRepository repository;

  GetSingleDeclarationUseCase(this.repository);

  @override
  Future<Either<Failure, DeclarationInfoEntity>> call(
    GetSingleDeclarationParams params,
  ) async {
    return repository.getSingleDeclaration(params.id, params.isTask);
  }
}

class GetSingleDeclarationParams extends Equatable {
  final String id;
  final bool isTask;

  const GetSingleDeclarationParams({
    required this.id,
    required this.isTask,
  });
  @override
  List<Object?> get props => [id];
}
