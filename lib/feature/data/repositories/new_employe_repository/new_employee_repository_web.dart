import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_new_employee_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_new_employee_repository.dart';
import 'package:dartz/dartz.dart';

class NewEmployeeRepositoryWeb implements INewEmployeeRepository {
  final INewEmployeeRemoteDataSource remoteDataSource;

  NewEmployeeRepositoryWeb({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<NewEmployeeModel>>> fetchNewEmployeeOnboardingSlides() async {
    try {
      final remoteListSlides = await remoteDataSource.fetchNewEmployeeOnboardingSlides();

      return Right(remoteListSlides);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
