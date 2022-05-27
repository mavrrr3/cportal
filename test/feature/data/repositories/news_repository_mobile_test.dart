import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/feature/data/repositories/news_repository_mobile.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSource extends Mock implements INewsLocalDataSource {}

class MockRemoteDataSource extends Mock implements INewsRemoteDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late NewsRepositoryMobile repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NewsRepositoryMobile(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('fetchNews()', () {
    const String tNewsTypeCode = 'NEWS';

    final ArticleModel tNewsArticle = ArticleModel(
      id: '999',
      articleType: const ArticleTypeModel(
        id: 'id',
        code: 'NEWS',
        description: 'description',
      ),
      header: 'Header 1',
      category: 'Новосталь-М',
      description: 'description',
      image:
          'https://w-dog.ru/wallpapers/0/62/349856802100204/zolotoj-bereg-okean-avstraliya-oteli-more-gorod.jpg',
      dateShow: DateTime.parse('2022-03-21T14:59:58.884Z'),
      externalLink: 'externalLink',
      show: true,
      userCreated: 'userCreated',
      dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
      userUpdate: 'userUpdate',
      dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
    );

    final NewsModel tNewsModel = NewsModel(
      show: true,
      article: [
        tNewsArticle,
      ],
    );

    final NewsEntity tNewsEntity = tNewsModel;

    test('should check if the device is online', () async {
      //arrange

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.fetchNews(any()))
          .thenAnswer((_) async => tNewsModel);
      //act
      await repository.fetchNews(tNewsTypeCode);
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });

    test(
      'should return NewsEntity when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.fetchNews(any()))
            .thenAnswer((_) async => tNewsModel);
        //act
        final result = await repository.fetchNews(tNewsTypeCode);
        //assert
        verify(() => mockRemoteDataSource.fetchNews(tNewsTypeCode));
        expect(result, equals(Right<dynamic, NewsEntity>(tNewsModel)));
      },
    );

    test(
      'should put NewsModel to cache when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.fetchNews(any()))
            .thenAnswer((_) async => tNewsModel);
        when(() => mockLocalDataSource.newsToCache(tNewsModel))
            .thenAnswer((_) async => Future<void>.value());

        //act
        await repository.fetchNews(tNewsTypeCode);
        //assert
        verify(() => mockRemoteDataSource.fetchNews(tNewsTypeCode));
        verifyNever(() => mockLocalDataSource.newsToCache(tNewsModel));
      },
    );
    test(
      'should return serverfailure when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.fetchNews(any()))
            .thenThrow(ServerException());
        //act
        final result = await repository.fetchNews(tNewsTypeCode);
        //assert
        verify(() => mockRemoteDataSource.fetchNews(tNewsTypeCode));
        verifyZeroInteractions(mockLocalDataSource);
        expect(
          result,
          equals(Left<ServerFailure, NewsEntity>(ServerFailure())),
        );
      },
    );

    test(
      'should return locally cached data when the cached data is present',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.newsToCache(tNewsModel))
            .thenAnswer((_) async => Future<void>.value());
        when(() => mockLocalDataSource.fetchNewsFromCache())
            .thenAnswer((_) async => tNewsModel);

        //act
        final result = await repository.fetchNews(tNewsTypeCode);

        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.fetchNewsFromCache());
        expect(result, equals(Right<Failure, NewsEntity>(tNewsEntity)));
      },
    );

    test(
      'should return CacheFailure when there is no cached data present',
      () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockLocalDataSource.fetchNewsFromCache())
            .thenThrow(CacheException());
        //act
        final result = await repository.fetchNews(tNewsTypeCode);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.fetchNewsFromCache());
        expect(result, equals(Left<CacheFailure, NewsEntity>(CacheFailure())));
      },
    );
  });
}
