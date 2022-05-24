import 'dart:developer';

import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews(String code);
}

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;

  NewsRemoteDataSource(this.localDatasource);

  @override
  Future<NewsModel> fetchNews(String code) async {
    try {
      final remoteNews = NewsModel(
        show: true,
        article: [
          newsArticle,
          quastion,
          newsArticle2,
          newsArticle4,
          newsArticle3,
          newsArticle5,
          newsArticle6,
          newsArticle7,
          newsArticle8,
          newsArticle9,
          quastion3,
          quastion2,
          quastion4,
        ],
      );

      log('NewsRemoteDataSource  ==========' + remoteNews.toString());
      await localDatasource.newsToCache(remoteNews);

      List<ArticleModel> articlesWithCode = remoteNews.article
          .where((article) => article.articleType.code == code)
          .toList();
      NewsModel news = NewsModel(
        show: true,
        article: [...articlesWithCode],
      );

      return news;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

final ArticleModel newsArticle = ArticleModel(
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

final ArticleModel newsArticle2 = ArticleModel(
  id: '555',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 2',
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

final ArticleModel newsArticle6 = ArticleModel(
  id: '5r5',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 6',
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
final ArticleModel newsArticle3 = ArticleModel(
  id: '123',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 3',
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

final ArticleModel newsArticle4 = ArticleModel(
  id: '5r5',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 4',
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
final ArticleModel newsArticle5 = ArticleModel(
  id: '12fff3',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 5',
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

final ArticleModel newsArticle7 = ArticleModel(
  id: '222fffff3',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 7',
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

final ArticleModel newsArticle8 = ArticleModel(
  id: '3',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 8',
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

final ArticleModel newsArticle9 = ArticleModel(
  id: 'kjlfljk34',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'NEWS',
    description: 'description',
  ),
  header: 'Header 9',
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

final ArticleModel quastion = ArticleModel(
  id: '333',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'QUASTION',
    description: 'description',
  ),
  header: 'Компенсация занятий спортом',
  category: 'Кадры',
  description:
      'И нет сомнений, что базовые сценарии поведения пользователей представляют собой не что иное, как квинтэссенцию победы маркетинга над разумом и должны быть смешаны с не уникальными данными до степени совершенной неузнаваемости, из-за чего возрастает их статус бесполезности.\n\nПо требованию собственника компенсация требует депозитный суд, хотя законодательством может быть установлено иное. Наследование своевременно исполняет закон. Пленум Высшего Арбитражного Суда неоднократно разъяснял, как доверенность противоречиво арендует правомерный сервитут. Оферта императивна. Страховой полис объективно опровергает международный индоссамент.\n\nАкционерное общество поручает конфиденциальный взаимозачет, исключая принцип презумпции невиновности. Перестрахование своевременно исполняет императивный сервитут, что не имеет аналогов в англо-саксонской правовой системе. Конституция, как бы это ни казалось парадоксальным, акцептована.',
  image:
      'https://img3.goodfon.ru/original/1152x864/e/2c/wyoming-grand-teton-national.jpg',
  dateShow: DateTime.parse('2022-03-21T14:59:58.884Z'),
  externalLink: 'externalLink',
  show: true,
  userCreated: 'userCreated',
  dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
  userUpdate: 'userUpdate',
  dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
);

final ArticleModel quastion2 = ArticleModel(
  id: '123',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'QUASTION',
    description: 'description',
  ),
  header: 'Из чего составляется ваш KPI',
  category: 'Продуктивность',
  description:
      'И нет сомнений, что базовые сценарии поведения пользователей представляют собой не что иное, как квинтэссенцию победы маркетинга над разумом и должны быть смешаны с не уникальными данными до степени совершенной неузнаваемости, из-за чего возрастает их статус бесполезности.\n\nПо требованию собственника компенсация требует депозитный суд, хотя законодательством может быть установлено иное. Наследование своевременно исполняет закон. Пленум Высшего Арбитражного Суда неоднократно разъяснял, как доверенность противоречиво арендует правомерный сервитут. Оферта императивна. Страховой полис объективно опровергает международный индоссамент.\n\nАкционерное общество поручает конфиденциальный взаимозачет, исключая принцип презумпции невиновности. Перестрахование своевременно исполняет императивный сервитут, что не имеет аналогов в англо-саксонской правовой системе. Конституция, как бы это ни казалось парадоксальным, акцептована.',
  image:
      'https://img3.goodfon.ru/original/1152x864/e/2c/wyoming-grand-teton-national.jpg',
  dateShow: DateTime.parse('2022-03-21T14:59:58.884Z'),
  externalLink: 'externalLink',
  show: true,
  userCreated: 'userCreated',
  dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
  userUpdate: 'userUpdate',
  dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
);

final ArticleModel quastion3 = ArticleModel(
  id: '777',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'QUASTION',
    description: 'description',
  ),
  header: 'Как взять отпуск?',
  category: 'Кадры',
  description:
      'И нет сомнений, что базовые сценарии поведения пользователей представляют собой не что иное, как квинтэссенцию победы маркетинга над разумом и должны быть смешаны с не уникальными данными до степени совершенной неузнаваемости, из-за чего возрастает их статус бесполезности.\n\nПо требованию собственника компенсация требует депозитный суд, хотя законодательством может быть установлено иное. Наследование своевременно исполняет закон. Пленум Высшего Арбитражного Суда неоднократно разъяснял, как доверенность противоречиво арендует правомерный сервитут. Оферта императивна. Страховой полис объективно опровергает международный индоссамент.\n\nАкционерное общество поручает конфиденциальный взаимозачет, исключая принцип презумпции невиновности. Перестрахование своевременно исполняет императивный сервитут, что не имеет аналогов в англо-саксонской правовой системе. Конституция, как бы это ни казалось парадоксальным, акцептована.',
  image:
      'https://img3.goodfon.ru/original/1152x864/e/2c/wyoming-grand-teton-national.jpg',
  dateShow: DateTime.parse('2022-03-21T14:59:58.884Z'),
  externalLink: 'externalLink',
  show: true,
  userCreated: 'userCreated',
  dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
  userUpdate: 'userUpdate',
  dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
);
final ArticleModel quastion4 = ArticleModel(
  id: '111',
  articleType: const ArticleTypeModel(
    id: 'id',
    code: 'QUASTION',
    description: 'description',
  ),
  header: 'Как взять больничный?',
  category: 'Кадры',
  description:
      'И нет сомнений, что базовые сценарии поведения пользователей представляют собой не что иное, как квинтэссенцию победы маркетинга над разумом и должны быть смешаны с не уникальными данными до степени совершенной неузнаваемости, из-за чего возрастает их статус бесполезности.\n\nПо требованию собственника компенсация требует депозитный суд, хотя законодательством может быть установлено иное. Наследование своевременно исполняет закон. Пленум Высшего Арбитражного Суда неоднократно разъяснял, как доверенность противоречиво арендует правомерный сервитут. Оферта императивна. Страховой полис объективно опровергает международный индоссамент.\n\nАкционерное общество поручает конфиденциальный взаимозачет, исключая принцип презумпции невиновности. Перестрахование своевременно исполняет императивный сервитут, что не имеет аналогов в англо-саксонской правовой системе. Конституция, как бы это ни казалось парадоксальным, акцептована.',
  image:
      'https://img3.goodfon.ru/original/1152x864/e/2c/wyoming-grand-teton-national.jpg',
  dateShow: DateTime.parse('2022-03-21T14:59:58.884Z'),
  externalLink: 'externalLink',
  show: true,
  userCreated: 'userCreated',
  dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
  userUpdate: 'userUpdate',
  dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
);
