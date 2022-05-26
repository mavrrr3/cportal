import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/biometric_info.dart';
import 'package:cportal_flutter/feature/data/repositories/biometric_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBiometricInfo extends Mock implements IBiometricInfo {}

void main() {
  late BiometricRepository repository;
  late MockBiometricInfo biometricInfo;
  late bool tIsAuth;
  late List<BiometricType> tListBiometricType;
  late Failure tFailure;

  setUp(() {
    biometricInfo = MockBiometricInfo();

    repository = BiometricRepository(
      biometricInfo: biometricInfo,
    );
  });
  tIsAuth = true;
  tListBiometricType = [BiometricType.face, BiometricType.fingerprint];
  tFailure = PlatformFailure();

  test(
    'should return [bool] when the call autheticate()',
    () async {
      //arrange
      when(() => biometricInfo.autheticate()).thenAnswer((_) async => tIsAuth);
      //act
      final result = await repository.autheticate();
      //assert
      verify(() => biometricInfo.autheticate());
      expect(result, equals(Right<Failure, bool>(tIsAuth)));
    },
  );

  test(
    'should return [Failure] when the call autheticate()',
    () async {
      //arrange
      when(() => biometricInfo.autheticate())
          .thenThrow(PlatformException(code: 'error'));
      //act
      final result = await repository.autheticate();
      //assert
      verify(() => biometricInfo.autheticate());
      expect(result, equals(Left<Failure, bool>(tFailure)));
    },
  );
  test(
    'should return [List<BiometricType>] when the call getBiometrics()',
    () async {
      //arrange
      when(() => biometricInfo.getBiometrics())
          .thenAnswer((_) async => tListBiometricType);
      //act
      final result = await repository.getBiometrics();
      //assert
      verify(() => biometricInfo.getBiometrics());
      expect(
        result,
        equals(Right<Failure, List<BiometricType>>(tListBiometricType)),
      );
    },
  );

  test(
    'should return [Failure] when the call getBiometrics()',
    () async {
      //arrange
      when(() => biometricInfo.getBiometrics())
          .thenThrow(PlatformException(code: 'error'));
      //act
      final result = await repository.getBiometrics();
      //assert
      verify(() => biometricInfo.getBiometrics());
      expect(
        result,
        equals(Left<Failure, List<BiometricType>>(tFailure)),
      );
    },
  );
}
