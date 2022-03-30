import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/usecase.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/domain/repositories/user_repository.dart';

class GetSingleUserUseCase extends UseCase<UserEntity, GetSingleUserParams> {
  final UserRepository userRepository;

  GetSingleUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(GetSingleUserParams params) async {
    return await userRepository.getSingleUser(params.id);
  }
}

class GetSingleUserParams extends Equatable {
  final String id;

  const GetSingleUserParams({required this.id});
  @override
  List<Object?> get props => [id];
}
