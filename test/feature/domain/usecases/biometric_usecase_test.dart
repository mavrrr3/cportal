import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/biometric_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'get_single_profile_usecase_test.dart';

class MockIBiometricRepository extends Mock implements IBiometricRepository {}

void main() {
  late BiometricUseCase useCase;
  late MockIBiometricRepository mockBiometricRepository;
  late bool tIsAuth;
  late List<BiometricType> tListBiometricType;
  late Failure tFailure;

  setUp(() {
    mockBiometricRepository = MockIBiometricRepository();

    useCase = BiometricUseCase(mockBiometricRepository);

    tIsAuth = true;

    tListBiometricType = [BiometricType.face, BiometricType.fingerprint];

    tFailure = ServerFailure();
  });

  test(
    'Return [bool] from repository',
    () async {
      //arrange
      when(() => mockBiometricRepository.autheticate())
          .thenAnswer((_) async => Right<Failure, bool>(tIsAuth));

      //act
      final result = await useCase.autheticate();

      //assert
      void getUserOrFailure(Either<Failure, bool> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final bool isAuth = either.asRight();
          expect(result, equals(Right<Failure, bool>(isAuth)));
        }
      }

      getUserOrFailure(result);
      verify(() => mockBiometricRepository.autheticate());
      verifyNoMoreInteractions(mockBiometricRepository);
    },
  );

  test(
    'Return [Failure] from repository',
    () async {
      //arrange
      when(() => mockBiometricRepository.autheticate())
          .thenAnswer((_) async => Left<Failure, bool>(tFailure));

      //act
      final result = await useCase.autheticate();

      //assert
      void getUserOrFailure(Either<Failure, bool> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final bool isAuth = either.asRight();
          expect(result, equals(Right<Failure, bool>(isAuth)));
        }
      }

      getUserOrFailure(result);
      verify(() => mockBiometricRepository.autheticate());
      verifyNoMoreInteractions(mockBiometricRepository);
    },
  );

  test(
    'Return [List<BiometricType>] from repository',
    () async {
      //arrange
      when(() => mockBiometricRepository.getBiometrics()).thenAnswer(
          (_) async => Right<Failure, List<BiometricType>>(tListBiometricType));

      //act
      final result = await useCase.getBiometrics();

      //assert
      void getUserOrFailure(Either<Failure, List<BiometricType>> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final List<BiometricType> bioTypes = either.asRight();
          expect(result, equals(Right<Failure, List<BiometricType>>(bioTypes)));
        }
      }

      getUserOrFailure(result);
      verify(() => mockBiometricRepository.getBiometrics());
      verifyNoMoreInteractions(mockBiometricRepository);
    },
  );
}
