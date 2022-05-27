import 'package:cportal_flutter/core/error/exception.dart';
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

    // final NewsEntity tNewsEntity = tNewsModel;

    test(
      'should return NewsEntity when the call to remote data source is successful',
      () async {
        //arrange
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
      'should return serverfailure when the call to remote data source is successful',
      () async {
        //arrange
        when(() => mockRemoteDataSource.fetchNews(any()))
            .thenThrow(ServerException());
        //act
        final result = await repository.fetchNews(tNewsTypeCode);
        //assert
        verify(() => mockRemoteDataSource.fetchNews(tNewsTypeCode));

        expect(
          result,
          equals(Left<ServerFailure, NewsEntity>(ServerFailure())),
        );
      },
    );
  });
}
