import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:dartz/dartz.dart';

abstract class INewEmployeeRepository {
  Future<Either<Failure, List<NewEmployeeEntity>>>
      fetchNewEmployeeOnboardingSlides();
}
