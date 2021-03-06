import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getSingleProfile(
    String id, {
    bool isMyProfile = false,
  });

  Future<Either<Failure, List<ProfileEntity>>> searchProfiles(String query);
}
