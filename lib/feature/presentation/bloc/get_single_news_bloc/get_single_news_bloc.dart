import 'dart:async';
import 'dart:developer';

import 'package:cportal_flutter/feature/domain/usecases/news/get_single_news_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class GetSingleNewsBloc extends Bloc<GetSingleNewsEvent, GetSingleNewsState> {
  final GetSingleNewsUseCase getSingleNews;

  GetSingleNewsBloc({required this.getSingleNews})
      : super(GetSingleNewsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<GetSingleNewsEventImpl>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr _onEvent(
    GetSingleNewsEventImpl event,
    Emitter emit,
  ) async {
    log('failureOrSingleNews.toString()');

    emit(GetSingleNewsLoadingState());

    String mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    final failureOrSingleNews = await getSingleNews(
      GetSingleNewsParams(id: event.id),
    );
    log(failureOrSingleNews.toString());
    failureOrSingleNews.fold(
      (failure) {
        emit(GetSingleNewsLoadingError(
          message: mapFailureToMessage(failure),
        ));
      },
      (singleNews) {
        emit(GetSingleNewsLoadedState(singleNews: singleNews));
      },
    );
  }
}
