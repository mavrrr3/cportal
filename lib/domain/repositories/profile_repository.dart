import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getSingleProfile(String id);
  Future<Either<Failure, List<ProfileEntity>>> searchProfiles(String query);
}
