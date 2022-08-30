import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IFilterRepository {
  Future<Either<Failure, FilterResponseEntity>> fetchContactsFilters();
  Future<Either<Failure, FilterResponseEntity>> fetchDeclarationsFilters();
  Future<Either<Failure, FilterResponseEntity>> fetchTasksFilters();
}
