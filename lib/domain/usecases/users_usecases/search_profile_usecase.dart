import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/domain/repositories/i_profile_repository.dart';

class SearchProfileUseCase
    extends IUseCase<List<ProfileEntity>, SearchProfilesParams> {
  final IProfileRepository profileRepository;

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
