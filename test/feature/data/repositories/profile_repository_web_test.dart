import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/data/repositories/profile_repository_web.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements IProfileRemoteDataSource {}

void main() {
  late ProfileRepositoryWeb repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();

    repository = ProfileRepositoryWeb(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('getSingleProfile', () {
    const String tProfileId = 'A1B2C3D4E5';

    // final ProfileModel tProfileModel = ProfileModel(
    //   id: 'A1B2C3D4E5',
    //   externalId: '8877',
    //   firstName: 'Александр',
    //   lastName: 'Дымченко',
    //   middleName: 'Валерьевич',
    //   birthday: '20.11.1984',
    //   email: 'aaa@novostal.ru',
    //   photoLink: '2.jpg',
    //   active: true,
    //   position: const PositionModel(
    //     id: 'a1b2c3d4',
    //     description: 'Начальник отдела',
    //     department: 'Информационные технологии',
    //   ),
    //   phone: const [
    //     PhoneModel(number: '25-425-655', suffix: '033', primary: true),
    //     PhoneModel(number: '987-65-06', suffix: '033', primary: false),
    //   ],
    //   userCreated: 'id_user_created',
    //   dateCreated: DateTime.parse('2022-03-21T14:37:12.068Z'),
    //   userUpdate: 'id_user_updated',
    //   dateUpdated: DateTime.parse('2022-03-21T14:37:12.068Z'),
    // );
    // final ProfileEntity tProfileEntity = tProfileModel;

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // Arrange.
        // when(() => mockRemoteDataSource.getSingleProfile(any()))
        //     .thenAnswer((_) async => tProfileModel);
        // Act..
        final result = await repository.getSingleProfile(tProfileId);
        // Assert.
        verify(() => mockRemoteDataSource.getSingleProfile(tProfileId));
        // expect(result, equals(Right<dynamic, ProfileEntity>(tProfileEntity)));
      },
    );
    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // Arrange.
        // when(() => mockRemoteDataSource.getSingleProfile(any()))
        //     .thenAnswer((_) async => tProfileModel);
        // Act..
        await repository.getSingleProfile(tProfileId);
        // Assert.

        verify(() => mockRemoteDataSource.getSingleProfile(tProfileId));
      },
    );
    test(
      'should return serverfailure when the call to remote data source is successful',
      () async {
        // Arrange.
        when(() => mockRemoteDataSource.getSingleProfile(tProfileId))
            .thenThrow(ServerException());
        // Act..
        final result = await repository.getSingleProfile(tProfileId);
        // Assert.
        verify(() => mockRemoteDataSource.getSingleProfile(tProfileId));
        expect(result, equals(Left<ServerFailure, dynamic>(ServerFailure())));
      },
    );
  });
}
