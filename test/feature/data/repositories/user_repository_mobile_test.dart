import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/data/repositories/user_repository_mobile.dart';
import 'package:cportal_flutter/feature/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock implements IUserLocalDataSource {}

class MockRemoteDataSource extends Mock implements IUserRemoteDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late UserRepositoryMobile repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryMobile(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
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

    test('should check if the device is online', () async {
      //arrange

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.login(any()))
          .thenAnswer((_) async => tUserModel);
      //act
      await repository.login(tConnectingCode);
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });

    test(
      'should return UserEntity when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.login(any()))
            .thenAnswer((_) async => tUserModel);
        //act
        final result = await repository.login(tConnectingCode);
        //assert
        verify(() => mockRemoteDataSource.login(tConnectingCode));
        expect(result, equals(Right<dynamic, UserEntity>(tUserEntity)));
      },
    );

    test(
      'should put UserModel to cache when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.login(any()))
            .thenAnswer((_) async => tUserModel);
        //act
        await repository.login(tConnectingCode);
        //assert
        verify(() => mockRemoteDataSource.login(tConnectingCode));
      },
    );
    test(
      'should return serverfailure when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.login(any()))
            .thenThrow(ServerException());
        //act
        final result = await repository.login(tConnectingCode);
        //assert
        verify(() => mockRemoteDataSource.login(tConnectingCode));
        verifyZeroInteractions(mockLocalDataSource);
        expect(
            result, equals(Left<ServerFailure, UserEntity>(ServerFailure())));
      },
    );

    test(
      'should return locally cached data when the cached data is present',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.currentUserToCache(tUserModel))
            .thenAnswer((_) async => Future.value());
        when(() => mockLocalDataSource.getCurrentUserFromCache())
            .thenAnswer((_) async => tUserModel);

        //act
        final result = await repository.login(tConnectingCode);

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCurrentUserFromCache());
        expect(result, equals(Right<dynamic, UserEntity>(tUserEntity)));
      },
    );

    test(
      'should return CacheFailure when there is no cached data present',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.getCurrentUserFromCache())
            .thenThrow(CacheException());
        //act
        final result = await repository.login(tConnectingCode);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCurrentUserFromCache());
        expect(result, equals(Left<CacheFailure, UserEntity>(CacheFailure())));
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
      //arrange
      when(() => mockLocalDataSource.currentUserToCache(tUserModel))
          .thenAnswer((_) async => Future.value());
      when(() => mockLocalDataSource.getCurrentUserFromCache())
          .thenAnswer((_) async => tUserModel);

      //act
      final Either<Failure, bool> result = await repository.checkAuth();

      //assert
      verify(() => mockLocalDataSource.getCurrentUserFromCache());
      expect(result, equals(result));
    });

    test('should return [Failure] if user is not Auth', () async {
      //arrange
      when(() => mockLocalDataSource.getCurrentUserFromCache())
          .thenThrow(CacheException());

      //act
      final Either<Failure, bool> result = await repository.checkAuth();

      //assert
      verify(() => mockLocalDataSource.getCurrentUserFromCache());
      expect(result, equals(result));
    });
  });
}
