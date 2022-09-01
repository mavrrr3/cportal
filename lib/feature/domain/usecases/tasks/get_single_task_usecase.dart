import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_tasks_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class GetSingleTaskUseCase
    extends IUseCase<DeclarationInfoEntity, GetSingleTaskParams> {
  final ITasksRepository repository;

  GetSingleTaskUseCase(this.repository);

  @override
  Future<Either<Failure, DeclarationInfoEntity>> call(
    GetSingleTaskParams params,
  ) async {
    return repository.getSingleTask(params.id);
  }
}

class GetSingleTaskParams extends Equatable {
  final String id;

  const GetSingleTaskParams({required this.id});
  @override
  List<Object?> get props => [id];
}
