import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/domain/repositories/i_profile_repository.dart';

class GetSingleProfileUseCase
    extends IUseCase<ProfileEntity, GetSingleProfileParams> {
  final IProfileRepository profileRepository;

  GetSingleProfileUseCase(this.profileRepository);

  @override
  Future<Either<Failure, ProfileEntity>> call(
    GetSingleProfileParams params,
  ) async {
    return await profileRepository.getSingleProfile(params.id);
  }
}

class GetSingleProfileParams extends Equatable {
  final String id;

  const GetSingleProfileParams({required this.id});
  @override
  List<Object?> get props => [id];
}
