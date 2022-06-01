import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/login_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'get_single_profile_usecase_test.dart';

class MockIUserRepository extends Mock implements IUserRepository {}

void main() {
  late LoginUserUseCase useCase;
  late MockIUserRepository mockUserRepository;
  late String tConnectingCode;
  late UserModel tUserModel;
  late Failure tFailure;

  setUp(() {
    mockUserRepository = MockIUserRepository();

    useCase = LoginUserUseCase(mockUserRepository);

    tConnectingCode = '111111';

    tUserModel = UserModel(
      id: 'id',
      userName: 'userName',
      profileId: 'profileId',
      lastLogin: DateTime.parse('2022-03-21T14:59:58.884Z'),
      blocked: false,
      dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
      userCreated: 'userCreated',
      dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
      userUpdated: 'userUpdated',
      userType: UserTypeModel(id: '1', code: 'ddd', description: 'ddd'),
    );

    tFailure = ServerFailure();
  });

  test(
    'Return [ProfileEntity] from repository',
    () async {
      // Arrange.
      when(() => mockUserRepository.login(any()))
          .thenAnswer((_) async => Right<Failure, UserEntity>(tUserModel));

      // Act..
      final result =
          await useCase.call(LoginUserParams(connectingCode: tConnectingCode));

      // Assert.
      void getUserOrFailure(Either<Failure, UserEntity> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final UserEntity user = either.asRight();
          expect(result, equals(Right<Failure, UserEntity>(user)));
        }
      }

      getUserOrFailure(result);
      verify(() => mockUserRepository.login(tConnectingCode));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );

  test(
    'Return [Failure] from repository',
    () async {
      // Arrange.
      when(() => mockUserRepository.login(any()))
          .thenAnswer((_) async => Left<Failure, UserEntity>(tFailure));

      // Act..
      final result =
          await useCase.call(LoginUserParams(connectingCode: tConnectingCode));

      // Assert.
      void getUserOrFailure(Either<Failure, UserEntity> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final UserEntity user = either.asRight();
          expect(result, equals(Right<Failure, UserEntity>(user)));
        }
      }

      getUserOrFailure(result);
      verify(() => mockUserRepository.login(tConnectingCode));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}
