import 'package:bloc_test/bloc_test.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';

import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUseCase extends Mock implements GetSingleProfileUseCase {}

void main() {
  late MockUseCase useCase;
  late GetSingleProfileBloc getSingleProfileBloc;
  late ProfileEntity tProfileEntity;
  setUp(() {
    useCase = MockUseCase();
    getSingleProfileBloc = GetSingleProfileBloc(getSingleProfile: useCase);
  });

  tearDown(() {
    getSingleProfileBloc.close();
  });

  group('GetSingleProfileBloc', () {
    tProfileEntity = ProfileEntity(
      id: 'A1B2C3D4E5',
      firstName: 'firstName',
      externalId: 'externalId',
      lastName: 'lastName',
      middleName: 'middleName',
      birthday: 'birthday',
      email: 'email',
      photoLink: 'photoLink',
      active: true,
      position: const PositionEntity(
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
    const String tProfileId = 'A1B2C3D4E5';
    ServerFailure tServerFailure = ServerFailure();
    CacheFailure tCacheFailure = CacheFailure();

    String _mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    test('bloc should have initial state as [GetSingleProfileEmptyState]', () {
      expect(getSingleProfileBloc.state, GetSingleProfileEmptyState());
    });

    blocTest<GetSingleProfileBloc, GetSingleProfileState>(
      'emits [GetSingleProfileLoadingState, GetSingleProfileLoadedState] when GetSingleProfileEventImpl is added.',
      build: () => getSingleProfileBloc,
      act: (GetSingleProfileBloc bloc) {
        when(() => useCase.call(const GetSingleProfileParams(id: tProfileId)))
            .thenAnswer(
          (_) async => Right<Failure, ProfileEntity>(tProfileEntity),
        );
        bloc.add(const GetSingleProfileEventImpl(tProfileId));
      },
      expect: () => [
        GetSingleProfileLoadingState(),
        GetSingleProfileLoadedState(profile: tProfileEntity),
      ],
      verify: (_) {
        verify(() => useCase.call(const GetSingleProfileParams(id: tProfileId)))
            .called(1);
      },
    );

    blocTest<GetSingleProfileBloc, GetSingleProfileState>(
      'emits [GetSingleProfileLoadingState, GetSingleProfileLoadingError] when ServerFailure().',
      build: () => getSingleProfileBloc,
      act: (GetSingleProfileBloc bloc) {
        when(() => useCase.call(const GetSingleProfileParams(id: tProfileId)))
            .thenAnswer(
          (_) async => Left<Failure, ProfileEntity>(tServerFailure),
        );
        bloc.add(const GetSingleProfileEventImpl(tProfileId));
      },
      expect: () => [
        GetSingleProfileLoadingState(),
        GetSingleProfileLoadingError(
          message: _mapFailureToMessage(tServerFailure),
        ),
      ],
      verify: (_) {
        verify(() => useCase.call(const GetSingleProfileParams(id: tProfileId)))
            .called(1);
      },
    );

    blocTest<GetSingleProfileBloc, GetSingleProfileState>(
      'emits [GetSingleProfileLoadingState, GetSingleProfileLoadingError] when CacheFailure().',
      build: () => getSingleProfileBloc,
      act: (GetSingleProfileBloc bloc) {
        when(() => useCase.call(const GetSingleProfileParams(id: tProfileId)))
            .thenAnswer(
          (_) async => Left<Failure, ProfileEntity>(tCacheFailure),
        );
        bloc.add(const GetSingleProfileEventImpl(tProfileId));
      },
      expect: () => [
        GetSingleProfileLoadingState(),
        GetSingleProfileLoadingError(
          message: _mapFailureToMessage(tCacheFailure),
        ),
      ],
      verify: (_) {
        verify(() => useCase.call(const GetSingleProfileParams(id: tProfileId)))
            .called(1);
      },
    );
  });
}
