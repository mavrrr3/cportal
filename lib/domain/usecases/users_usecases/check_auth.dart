import 'package:cportal_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class CheckAuthUseCase {
  final UserRepository userRepository;

  CheckAuthUseCase(this.userRepository);

  Future<Either<Failure, bool>> call() async {
    return await userRepository.checkAuth();
  }
}
