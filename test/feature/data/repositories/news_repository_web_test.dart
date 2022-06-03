import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/feature/data/repositories/news_repository_web.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements INewsRemoteDataSource {}

void main() {
  late NewsRepositoryWeb repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();

    repository = NewsRepositoryWeb(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('fetchNews()', () {
    const String tNewsTypeCode = 'NEWS';

    final ArticleModel tNewsArticle = ArticleModel(
      id: 'id',
      date: DateTime.parse('2022-03-21T14:59:58.884Z'),
      category: 'Новости',
      header: 'header',
      content: const [
        ParagraphModel(
          template: '1',
          content: 'content',
          imageTitle: '',
          image: '',
        ),
        ParagraphModel(
          template: '2',
          content: 'content',
          imageTitle: '',
          image: 'imagesTitle',
        ),
      ],
      image:
          'https://w-dog.ru/wallpapers/0/62/349856802100204/zolotoj-bereg-okean-avstraliya-oteli-more-gorod.jpg',
    );
    final NewsModel tNewsModel = NewsModel(
      response: ResponseModel(
        count: 1,
        update: 1,
        categories: const ['Новости'],
        articles: [tNewsArticle],
      ),
    );

    test(
      'should return NewsEntity when the call to remote data source is successful',
      () async {
        // Arrange.
        when(() => mockRemoteDataSource.fetchNews(any()))
            .thenAnswer((_) async => tNewsModel);
        // Act..
        final result = await repository.fetchNews(1);
        // Assert.
        verify(() => mockRemoteDataSource.fetchNews(1));
        expect(result, equals(Right<dynamic, NewsEntity>(tNewsModel)));
      },
    );

    test(
      'should return serverfailure when the call to remote data source is successful',
      () async {
        // Arrange.
        when(() => mockRemoteDataSource.fetchNews(any()))
            .thenThrow(ServerException());
        // Act..
        final result = await repository.fetchNews(1);
        // Assert.
        verify(() => mockRemoteDataSource.fetchNews(1));

        expect(
          result,
          equals(Left<ServerFailure, NewsEntity>(ServerFailure())),
        );
      },
    );
  });
}
