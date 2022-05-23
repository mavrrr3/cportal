import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_profile_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/get_single_profile_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_single_profile_usecase_test.mocks.dart';

@GenerateMocks([IProfileRepository])
void main() {
  late GetSingleProfileUseCase useCase;
  late MockIProfileRepository mockProfileRepository;
  late ProfileModel tProfileEntity;
  late String tProfileId;
  late Failure tFailure;

  setUp(() {
    mockProfileRepository = MockIProfileRepository();
    useCase = GetSingleProfileUseCase(mockProfileRepository);

    tProfileEntity = ProfileModel(
      id: 'A1B2C3D4E5',
      firstName: 'firstName',
      externalId: 'externalId',
      lastName: 'lastName',
      middleName: 'middleName',
      birthday: 'birthday',
      email: 'email',
      photoLink: 'photoLink',
      active: true,
      position: const PositionModel(
        id: 'id',
        description: 'description',
        department: 'department',
      ),
      phone: const [],
      userCreated: 'userCreated',
      dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
      userUpdate: 'userUpdate',
      dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
    );

    tProfileId = 'A1B2C3D4E5';
    tFailure = ServerFailure();
  });

  test(
    'Return [ProfileEntity] from repository',
    () async {
      // arange
      when(mockProfileRepository.getSingleProfile(tProfileId))
          .thenAnswer((_) async => Right(tProfileEntity));

      // act
      final Either<Failure, ProfileEntity> result =
          await useCase.call(GetSingleProfileParams(id: tProfileId));

      // assert
      void getProfileOrEntity(Either<Failure, ProfileEntity> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final ProfileEntity profileEntity = either.asRight();
          expect(result, equals(Right<dynamic, ProfileEntity>(profileEntity)));
        }
      }

      getProfileOrEntity(result);
      verify(mockProfileRepository.getSingleProfile(tProfileId));
      verifyNoMoreInteractions(mockProfileRepository);
    },
  );

  test(
    'Return [Failure] from repository',
    () async {
      // arange
      when(mockProfileRepository.getSingleProfile(tProfileId))
          .thenAnswer((_) async => Left(tFailure));

      // act
      final Either<Failure, ProfileEntity> result =
          await useCase.call(GetSingleProfileParams(id: tProfileId));

      // assert
      void getProfileOrEntity(Either<Failure, ProfileEntity> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final ProfileEntity profileEntity = either.asRight();
          expect(result, equals(Right<dynamic, ProfileEntity>(profileEntity)));
        }
      }

      getProfileOrEntity(result);
      verify(mockProfileRepository.getSingleProfile(tProfileId));
      verifyNoMoreInteractions(mockProfileRepository);
    },
  );
}

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value as R;
  L asLeft() => (this as Left).value as L;
}
