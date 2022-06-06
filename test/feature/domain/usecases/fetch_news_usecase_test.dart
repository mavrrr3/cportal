import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'get_single_profile_usecase_test.dart';

class MockINewsRepository extends Mock implements INewsRepository {}

void main() {
  late FetchNewsUseCase useCase;
  late MockINewsRepository mockNewsRepository;
  late NewsEntity tNewsEntity;
  late int tPage;
  late Failure tFailure;

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

  setUp(() {
    mockNewsRepository = MockINewsRepository();

    useCase = FetchNewsUseCase(mockNewsRepository);

    tNewsEntity = NewsModel(
      response: ResponseModel(
        count: 1,
        update: 1,
        categories: const ['Новости'],
        articles: [tNewsArticle],
      ),
    );

    tPage = 0;
    tFailure = ServerFailure();
  });

  test(
    'Return [NewsEntity] from repository',
    () async {
      // Arrange.
      when(() => mockNewsRepository.fetchNews(any()))
          .thenAnswer((_) async => Right<Failure, NewsEntity>(tNewsEntity));

      // Act..
      final result = await useCase(FetchNewsParams(page: tPage));

      // Assert.
      void getNewsOrFailure(Either<Failure, NewsEntity> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final NewsEntity news = either.asRight();
          expect(result, equals(Right<Failure, NewsEntity>(news)));
        }
      }

      getNewsOrFailure(result);
      verify(() => mockNewsRepository.fetchNews(tPage));
      verifyNoMoreInteractions(mockNewsRepository);
    },
  );

  test(
    'Return [Failure] from repository',
    () async {
      // Arrange.
      when(() => mockNewsRepository.fetchNews(any()))
          .thenAnswer((_) async => Left<Failure, NewsEntity>(tFailure));

      // Act..
      final result = await useCase(FetchNewsParams(page: tPage));

      // Assert.
      void getNewsOrFailure(Either<Failure, NewsEntity> either) {
        if (either.isLeft()) {
          final Failure failure = either.asLeft();
          expect(tFailure, failure);
        } else {
          final NewsEntity news = either.asRight();
          expect(result, equals(Right<Failure, NewsEntity>(news)));
        }
      }

      getNewsOrFailure(result);
      verify(() => mockNewsRepository.fetchNews(tPage));
      verifyNoMoreInteractions(mockNewsRepository);
    },
  );
}
