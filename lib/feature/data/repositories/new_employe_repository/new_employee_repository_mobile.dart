import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_new_employee_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_new_employee_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_new_employee_repository.dart';
import 'package:dartz/dartz.dart';

class NewEmployeeRepositoryMobile implements INewEmployeeRepository {
  final INewEmployeeRemoteDataSource remoteDataSource;
  final INewEmployeeLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  NewEmployeeRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<NewEmployeeModel>>> fetchNewEmployeeOnboardingSlides() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListSlides = await remoteDataSource.fetchNewEmployeeOnboardingSlides();

        await localDataSource.newEmployeeSlidesToCache(remoteListSlides);

        return Right(remoteListSlides);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListSlides = await localDataSource.fetchNewEmployeeOnboardingSlidesFromCache();

        return Right(localListSlides);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
