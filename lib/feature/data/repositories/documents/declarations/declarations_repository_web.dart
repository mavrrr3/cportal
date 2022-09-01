import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_declarations_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class DeclarationsRepositoryWeb extends IDeclarationRepository {
  final IDeclarationsRemoteDataSource remoteDataSource;

  DeclarationsRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DeclarationCardEntity>>> fetchDeclarations(
    int page,
  ) async {
    try {
      final remoteDeclarations = await remoteDataSource.fetchDeclarations(page);

      return Right(remoteDeclarations);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DeclarationInfoEntity>> getSingleDeclaration(
    String id,
    bool isTask,
  ) async {
    try {
      final remoteDeclarations =
          await remoteDataSource.getSingleDeclaration(id);

      return Right(remoteDeclarations);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DeclarationCardEntity>>> searchDeclarations(
    String query,
  ) {
    throw UnimplementedError();
  }
}
