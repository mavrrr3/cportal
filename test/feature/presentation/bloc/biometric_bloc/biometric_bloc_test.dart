import 'package:bloc_test/bloc_test.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/biometric_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockUseCase extends Mock implements BiometricUseCase {}

void main() {
  late MockUseCase useCase;
  late BiometricBloc biometricBloc;
  late bool tIsAuth;
  late List<BiometricType> tListBiometricType;
  late Failure tFailure;

  setUp(() {
    useCase = MockUseCase();
    biometricBloc = BiometricBloc(useCase);
  });

  tearDown(() {
    biometricBloc.close();
  });

  tIsAuth = true;
  tListBiometricType = [BiometricType.face, BiometricType.fingerprint];
  tFailure = PlatformFailure();

  test('bloc should have initial state as [PinCodeState]', () {
    expect(biometricBloc.state, const BiometricState());
  });

  blocTest<BiometricBloc, BiometricState>(
    '''emits [ BiometricEnum.authenticated, tListBiometricType] when return bool.''',
    build: () => biometricBloc,
    act: (bloc) {
      when(() => useCase.autheticate()).thenAnswer((_) async => Right(tIsAuth));
      when(() => useCase.getBiometrics())
          .thenAnswer((_) async => Right(tListBiometricType));

      bloc.add(const GetBiometricEvent());
    },
    expect: () => [
      const BiometricState(
        listBiometric: [],
        authStatus: BiometricEnum.authenticated,
      ),
      BiometricState(
        listBiometric: tListBiometricType,
        authStatus: BiometricEnum.authenticated,
      ),
    ],
    verify: (_) {
      verify(() => useCase.autheticate()).called(1);
      verify(() => useCase.getBiometrics()).called(1);
    },
  );

  blocTest<BiometricBloc, BiometricState>(
    '''emits [ BiometricEnum.error, tListBiometricType] when autheticate() return failure getBiometrics() return tListBiometricType.''',
    build: () => biometricBloc,
    act: (bloc) {
      when(() => useCase.autheticate()).thenAnswer((_) async => Left(tFailure));
      when(() => useCase.getBiometrics())
          .thenAnswer((_) async => Right(tListBiometricType));

      bloc.add(const GetBiometricEvent());
    },
    expect: () => [
      const BiometricState(
        listBiometric: [],
        authStatus: BiometricEnum.error,
      ),
      BiometricState(
        listBiometric: tListBiometricType,
        authStatus: BiometricEnum.error,
      ),
    ],
    verify: (_) {
      verify(() => useCase.autheticate()).called(1);
      verify(() => useCase.getBiometrics()).called(1);
    },
  );

  blocTest<BiometricBloc, BiometricState>(
    '''emits [ BiometricEnum.error] when autheticate() return failure getBiometrics() return failure.''',
    build: () => biometricBloc,
    act: (bloc) {
      when(() => useCase.autheticate()).thenAnswer((_) async => Left(tFailure));
      when(() => useCase.getBiometrics())
          .thenAnswer((_) async => Left(tFailure));

      bloc.add(const GetBiometricEvent());
    },
    expect: () => [
      const BiometricState(
        listBiometric: [],
        authStatus: BiometricEnum.error,
      ),
    ],
    verify: (_) {
      verify(() => useCase.autheticate()).called(1);
      verify(() => useCase.getBiometrics()).called(1);
    },
  );

  blocTest<BiometricBloc, BiometricState>(
    '''emits [ BiometricEnum.error] when autheticate() return bool getBiometrics() return failure.''',
    build: () => biometricBloc,
    act: (bloc) {
      when(() => useCase.autheticate()).thenAnswer((_) async => Right(tIsAuth));
      when(() => useCase.getBiometrics())
          .thenAnswer((_) async => Left(tFailure));

      bloc.add(const GetBiometricEvent());
    },
    expect: () => [
      const BiometricState(
        listBiometric: [],
        authStatus: BiometricEnum.authenticated,
      ),
      const BiometricState(
        listBiometric: [],
        authStatus: BiometricEnum.error,
      ),
    ],
    verify: (_) {
      verify(() => useCase.autheticate()).called(1);
      verify(() => useCase.getBiometrics()).called(1);
    },
  );
}
