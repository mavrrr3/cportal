import 'package:dartz/dartz.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/declaration_datasource/declaration_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/declaration_datasource/declaration_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/declaration_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';

class DeclarationRepositoryMobile extends IDeclarationRepository {
  final IDeclarationRemoteDataSource remoteDataSource;
  final IDeclarationLocalDataSource localDataSource;
  final INetworkInfo networkInfo;
  DeclarationRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<DeclarationEntity>>> fetchDeclarations(
    int page,
  ) async {
    throw UnimplementedError();
    // if (await networkInfo.isConnected) {
    //   try {
    //     final remoteNews = await remoteDataSource.fetchDeclarations(page);

    //     return Right(remoteNews);
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   try {
    //     final localNews = await localDataSource.fetchDeclarationsFromCache();

    //     return Right(localNews);
    //   } on CacheException {
    //     return Left(CacheFailure());
    //   }
    // }
  }

  @override
  Future<Either<Failure, DeclarationEntity>> getSingleDeclaration(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DeclarationEntity>>> searchDeclarations(
    String query,
  ) {
    throw UnimplementedError();
  }
}
