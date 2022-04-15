import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class CheckAuthUseCase {
  final IUserRepository userRepository;

  CheckAuthUseCase(this.userRepository);

  Future<Either<Failure, bool>> call() async {
    return await userRepository.checkAuth();
  }
}
