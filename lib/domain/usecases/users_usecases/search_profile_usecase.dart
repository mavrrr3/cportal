import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/usecase.dart';
import 'package:cportal_flutter/domain/repositories/profile_repository.dart';

class SearchProfileUseCase
    extends UseCase<List<ProfileEntity>, SearchProfilesParams> {
  final ProfileRepository profileRepository;

  SearchProfileUseCase(this.profileRepository);

  @override
  Future<Either<Failure, List<ProfileEntity>>> call(
    SearchProfilesParams params,
  ) async {
    return await profileRepository.searchProfiles(params.query);
  }
}

class SearchProfilesParams extends Equatable {
  final String query;

  const SearchProfilesParams({required this.query});
  @override
  List<Object?> get props => [query];
}
