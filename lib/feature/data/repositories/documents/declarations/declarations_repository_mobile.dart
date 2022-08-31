import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_declarations_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_declarations_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';

class DeclarationsRepositoryMobile extends IDeclarationRepository {
  final IDeclarationsRemoteDataSource remoteDataSource;
  final IDeclarationsLocalDataSource localDataSource;
  final INetworkInfo networkInfo;
  DeclarationsRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<DeclarationCardEntity>>> fetchDeclarations(
    int page,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDeclarations =
            await remoteDataSource.fetchDeclarations(page);
        if (remoteDeclarations.isNotEmpty) {
          await localDataSource.declarationsToCache(remoteDeclarations, page);
        }

        return Right(remoteDeclarations);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locaDeclarations =
            await localDataSource.fetchDeclarationsFromCache(page);

        return Right(locaDeclarations);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, DeclarationInfoEntity>> getSingleDeclaration(
    String id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDeclarations =
            await remoteDataSource.getSingleDeclaration(id);

        return Right(remoteDeclarations);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
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
