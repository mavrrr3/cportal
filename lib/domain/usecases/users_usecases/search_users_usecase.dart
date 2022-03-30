import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/usecase.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/domain/repositories/user_repository.dart';

class SearchUsersUseCase extends UseCase<List<UserEntity>, SearchUsersParams> {
  final UserRepository userRepository;

  SearchUsersUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(
    SearchUsersParams params,
  ) async {
    return await userRepository.searchUsers(params.query);
  }
}

class SearchUsersParams extends Equatable {
  final String query;

  const SearchUsersParams({required this.query});
  @override
  List<Object?> get props => [query];
}
