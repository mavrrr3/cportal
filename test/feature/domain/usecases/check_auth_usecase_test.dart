import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/check_auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'get_single_profile_usecase_test.dart';

class MockIUserRepository extends Mock implements IUserRepository {}

void main() {
  late CheckAuthUseCase useCase;
  late MockIUserRepository mockUserRepository;
  late bool tIsAuth;
  late Failure tFailure;

  setUp(() {
    mockUserRepository = MockIUserRepository();
    useCase = CheckAuthUseCase(mockUserRepository);
    tIsAuth = false;
    tFailure = ServerFailure();
  });

  test(
    'Return [boolean] from repository',
    () async {
      // Arrange.

      when(() => mockUserRepository.checkAuth())
          .thenAnswer((_) async => Right<Failure, bool>(tIsAuth));

      // Act..
      final result = await useCase.call();

      // Assert.
      void getStringOrEntity(Either<Failure, bool> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final bool isAuth = either.asRight();
          expect(result, equals(Right<Failure, bool>(isAuth)));
        }
      }

      getStringOrEntity(result);
      verify(() => mockUserRepository.checkAuth());
      verifyNoMoreInteractions(mockUserRepository);
    },
  );

  test(
    'Return [Failure] from repository',
    () async {
      // Arrange.

      when(() => mockUserRepository.checkAuth())
          .thenAnswer((_) async => Left<Failure, bool>(tFailure));

      // Act..
      final result = await useCase.call();

      // Assert.
      void getStringOrEntity(Either<Failure, bool> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final bool isAuth = either.asRight();
          expect(result, equals(Right<Failure, bool>(isAuth)));
        }
      }

      getStringOrEntity(result);
      verify(() => mockUserRepository.checkAuth());
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
