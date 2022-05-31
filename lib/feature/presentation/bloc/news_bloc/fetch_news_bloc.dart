import 'dart:async';
import 'dart:developer';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/fetch_news_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

// Инам для выдачи NewsEntity Новости, Вопросы, Справочник.

class FetchNewsBloc extends Bloc<FetchNewsEvent, FetchNewsState> {
  final FetchNewsUseCase fetchNews;

  FetchNewsBloc({required this.fetchNews}) : super(FetchNewsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchNewsEventImpl>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr _onEvent(
    FetchNewsEventImpl event,
    Emitter emit,
  ) async {
    emit(FetchNewsLoadingState());
    log('Отработал эвент: $event');

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

    final failureOrNews =
        await fetchNews(FetchNewsParams(code: newsCode(event.newsCodeEnum)));

    failureOrNews.fold(
      (failure) {
        emit(FetchNewsLoadingError(
          message: _mapFailureToMessage(failure),
        ));
      },
      (news) {
        /// Создание листа со всеми вкладками.
        final List<String> tabs = [];
        if (event.newsCodeEnum == NewsCodeEnum.news) {
          tabs.add('Все');
        }
        for (final item in news.response.articles) {
          if (!tabs.contains(item.category)) {
            tabs.add(item.category);
          }
        }
        log(tabs.toString());
        emit(FetchNewsLoadedState(news: news, tabs: tabs));
      },
    );
  }
}

enum NewsCodeEnum { news, quastion, catalog }

String newsCode(NewsCodeEnum codeEnum) {
  switch (codeEnum) {
    case NewsCodeEnum.news:
      return 'NEWS';
    case NewsCodeEnum.quastion:
      return 'QUASTION';
    default:
      return 'CATALOG';
  }
}
