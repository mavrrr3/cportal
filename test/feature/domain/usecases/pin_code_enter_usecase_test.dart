import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/pin_code_enter_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'get_single_profile_usecase_test.dart';

class MockIPinCodeRepository extends Mock implements IPinCodeRepository {}

void main() {
  late PinCodeEnterUseCase useCase;
  late MockIPinCodeRepository mockPinCodeRepository;
  late String tPinCode;
  late Failure tFailure;

  setUp(() {
    mockPinCodeRepository = MockIPinCodeRepository();
    useCase = PinCodeEnterUseCase(mockPinCodeRepository);
    tPinCode = '1234';
    tFailure = ServerFailure();
  });

  test(
    'Return [String?] from repository',
    () async {
      // Arrange.
      when(() => mockPinCodeRepository.getPin())
          .thenAnswer((_) async => tPinCode);

      // Act..
      final result = await useCase.getPin();

      // Assert.
      verify(() => mockPinCodeRepository.getPin());
      expect(result, equals(tPinCode));
    },
  );

  test(
    'Return [String] from repository',
    () async {
      // Arrange.
      when(() => mockPinCodeRepository.writePin(any()))
          .thenAnswer((_) async => Right<Failure, String>(tPinCode));

      // Act..
      final result = await useCase.call(PinCodeParams(pinCode: tPinCode));

      // Assert.
      void getStringOrFailure(Either<Failure, String> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final String pinCode = either.asRight();
          expect(result, equals(Right<Failure, String>(pinCode)));
        }
      }

      getStringOrFailure(result);
      verify(() => mockPinCodeRepository.writePin(tPinCode));
      verifyNoMoreInteractions(mockPinCodeRepository);
    },
  );

  test(
    'Return [Failure] from repository',
    () async {
      // Arrange.
      when(() => mockPinCodeRepository.writePin(any()))
          .thenAnswer((_) async => Left<Failure, String>(tFailure));

      // Act..
      final result = await useCase.call(PinCodeParams(pinCode: tPinCode));

      // Assert.
      void getStringOrFailure(Either<Failure, String> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final String pinCode = either.asRight();
          expect(result, equals(Right<Failure, String>(pinCode)));
        }
      }

      getStringOrFailure(result);
      verify(() => mockPinCodeRepository.writePin(tPinCode));
      verifyNoMoreInteractions(mockPinCodeRepository);
    },
  );
}
