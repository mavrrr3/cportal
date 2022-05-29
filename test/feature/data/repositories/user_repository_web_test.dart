import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/data/repositories/user_repository_web.dart';
import 'package:cportal_flutter/feature/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock implements IUserLocalDataSource {}

class MockRemoteDataSource extends Mock implements IUserRemoteDataSource {}

void main() {
  late UserRepositoryWeb repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();

    repository = UserRepositoryWeb(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('login()', () {
    const String tConnectingCode = '123456';

    final UserModel tUserModel = UserModel(
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

    final UserEntity tUserEntity = tUserModel;

    test(
      'should return UserEntity when the call to remote data source is successful',
      () async {
        // Arrange.
        when(() => mockRemoteDataSource.login(any()))
            .thenAnswer((_) async => tUserModel);

        // Act..
        final result = await repository.login(tConnectingCode);
        // Assert.
        verify(() => mockRemoteDataSource.login(tConnectingCode));
        expect(result, equals(Right<dynamic, UserEntity>(tUserEntity)));
      },
    );

    test(
      'should put UserModel to cache when the call to remote data source is successful',
      () async {
        // Arrange.
        when(() => mockRemoteDataSource.login(any()))
            .thenAnswer((_) async => tUserModel);
        // Act..
        await repository.login(tConnectingCode);
        // Assert.
        verify(() => mockRemoteDataSource.login(tConnectingCode));
      },
    );
    test(
      'should return serverfailure when the call to remote data source is successful',
      () async {
        // Arrange.
        when(() => mockRemoteDataSource.login(any()))
            .thenThrow(ServerException());
        // Act..
        final result = await repository.login(tConnectingCode);
        // Assert.
        verify(() => mockRemoteDataSource.login(tConnectingCode));
        verifyZeroInteractions(mockLocalDataSource);
        expect(
          result,
          equals(Left<ServerFailure, UserEntity>(ServerFailure())),
        );
      },
    );
  });

  group('checkAuth()', () {
    final UserModel tUserModel = UserModel(
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

    test('should return [bool] if user is Auth', () async {
      // Arrange.
      when(() => mockLocalDataSource.currentUserToCache(tUserModel))
          .thenAnswer((_) async => Future.value());
      when(() => mockLocalDataSource.getCurrentUserFromCache())
          .thenAnswer((_) async => tUserModel);

      // Act..
      final Either<Failure, bool> result = await repository.checkAuth();

      // Assert.
      verify(() => mockLocalDataSource.getCurrentUserFromCache());
      expect(result, equals(result));
    });

    test('should return [Failure] if user is not Auth', () async {
      // Arrange.
      when(() => mockLocalDataSource.getCurrentUserFromCache())
          .thenThrow(CacheException());

      // Act..
      final Either<Failure, bool> result = await repository.checkAuth();

      // Assert.
      verify(() => mockLocalDataSource.getCurrentUserFromCache());
      expect(result, equals(result));
    });
  });
}
