// import 'package:cportal_flutter/core/error/cache_exception.dart';
// import 'package:cportal_flutter/core/error/server_exception.dart';
// import 'package:cportal_flutter/core/error/failure.dart';
// import 'package:cportal_flutter/core/platform/i_network_info.dart';
// import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
// import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
// import 'package:cportal_flutter/feature/data/models/article_model.dart';
// import 'package:cportal_flutter/feature/data/models/news_model.dart';
// import 'package:cportal_flutter/feature/data/repositories/news_repository_mobile.dart';
// import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
// import 'package:dartz/dartz.dart';
// import 'package:test/test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLocalDataSource extends Mock implements INewsLocalDataSource {}

// class MockRemoteDataSource extends Mock implements INewsRemoteDataSource {}

// class MockNetworkInfo extends Mock implements INetworkInfo {}

// void main() {
//   late NewsRepositoryMobile repository;
//   late MockRemoteDataSource mockRemoteDataSource;
//   late MockLocalDataSource mockLocalDataSource;
//   late MockNetworkInfo mockNetworkInfo;

//   setUp(() {
//     mockRemoteDataSource = MockRemoteDataSource();
//     mockLocalDataSource = MockLocalDataSource();
//     mockNetworkInfo = MockNetworkInfo();
//     repository = NewsRepositoryMobile(
//       remoteDataSource: mockRemoteDataSource,
//       localDataSource: mockLocalDataSource,
//       networkInfo: mockNetworkInfo,
//     );
//   });

//   group('fetchNews()', () {
//     const int tPage = 1;
//     final ArticleModel tNewsArticle = ArticleModel(
//       id: 'id',
//       date: DateTime.parse('2022-03-21T14:59:58.884Z'),
//       category: 'Новости',
//       header: 'header',
//       content: const [
//         ParagraphModel(
//           template: '1',
//           content: 'content',
//           imageTitle: '',
//           image: '',
//         ),
//         ParagraphModel(
//           template: '2',
//           content: 'content',
//           imageTitle: '',
//           image: 'imagesTitle',
//         ),
//       ],
//       image:
//           'https://w-dog.ru/wallpapers/0/62/349856802100204/zolotoj-bereg-okean-avstraliya-oteli-more-gorod.jpg',
//     );
//     final NewsModel tNewsModel = NewsModel(
//       response: ResponseModel(
//         count: 1,
//         update: 1,
//         categories: const ['Новости'],
//         articles: [tNewsArticle],
//       ),
//     );

//     final NewsEntity tNewsEntity = tNewsModel;

//     test('should check if the device is online', () async {
//       // Arrange.

//       when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//       when(() => mockRemoteDataSource.fetchNews(any()))
//           .thenAnswer((_) async => tNewsModel);
//       // Act..
//       await repository.fetchNews(tPage);
//       // Assert.
//       verify(() => mockNetworkInfo.isConnected);
//     });

//     test(
//       'should return NewsEntity when the call to remote data source is successful',
//       () async {
//         // Arrange.
//         when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

//         when(() => mockRemoteDataSource.fetchNews(any()))
//             .thenAnswer((_) async => tNewsModel);
//         // Act..
//         final result = await repository.fetchNews(tPage);
//         // Assert.
//         verify(() => mockRemoteDataSource.fetchNews(tPage));
//         expect(result, equals(Right<dynamic, NewsEntity>(tNewsModel)));
//       },
//     );

//     test(
//       'should put NewsModel to cache when the call to remote data source is successful',
//       () async {
//         // Arrange.
//         when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

//         when(() => mockRemoteDataSource.fetchNews(any()))
//             .thenAnswer((_) async => tNewsModel);
//         when(() => mockLocalDataSource.newsToCache(tNewsModel))
//             .thenAnswer((_) async => Future<void>.value());

//         // Act..
//         await repository.fetchNews(tPage);
//         // Assert.
//         verify(() => mockRemoteDataSource.fetchNews(tPage));
//         verifyNever(() => mockLocalDataSource.newsToCache(tNewsModel));
//       },
//     );
//     test(
//       'should return serverfailure when the call to remote data source is successful',
//       () async {
//         // Arrange.
//         when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         when(() => mockRemoteDataSource.fetchNews(any()))
//             .thenThrow(ServerException());
//         // Act..
//         final result = await repository.fetchNews(tPage);
//         // Assert.
//         verify(() => mockRemoteDataSource.fetchNews(tPage));
//         verifyZeroInteractions(mockLocalDataSource);
//         expect(
//           result,
//           equals(Left<ServerFailure, NewsEntity>(ServerFailure())),
//         );
//       },
//     );

//     test(
//       'should return locally cached data when the cached data is present',
//       () async {
//         // Arrange.
//         when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
//         when(() => mockLocalDataSource.newsToCache(tNewsModel))
//             .thenAnswer((_) async => Future<void>.value());
//         when(() => mockLocalDataSource.fetchNewsFromCache())
//             .thenAnswer((_) async => tNewsModel);

//         // Act..
//         final result = await repository.fetchNews(tPage);

//         // Assert.
//         verifyZeroInteractions(mockRemoteDataSource);
//         verify(() => mockLocalDataSource.fetchNewsFromCache());
//         expect(result, equals(Right<Failure, NewsEntity>(tNewsEntity)));
//       },
//     );

//     test(
//       'should return CacheFailure when there is no cached data present',
//       () async {
//         // Arrange.
//         when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
//         when(() => mockLocalDataSource.fetchNewsFromCache())
//             .thenThrow(CacheException());
//         // Act..
//         final result = await repository.fetchNews(tPage);
//         // Assert.
//         verifyZeroInteractions(mockRemoteDataSource);
//         verify(() => mockLocalDataSource.fetchNewsFromCache());
//         expect(result, equals(Left<CacheFailure, NewsEntity>(CacheFailure())));
//       },
//     );
//   });
// }
