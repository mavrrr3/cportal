import 'dart:async';

import 'package:cportal_flutter/feature/domain/usecases/questions/get_single_question_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class GetSingleQuestionBloc
    extends Bloc<GetSingleQuestionEvent, GetSingleQuestionState> {
  final GetSingleQuestionUseCase getSingleQuestion;

  GetSingleQuestionBloc({required this.getSingleQuestion})
      : super(GetSingleQuestionEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<GetSingleQuestionEventImpl>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr _onEvent(
    GetSingleQuestionEventImpl event,
    Emitter emit,
  ) async {
    emit(GetSingleQuestionLoadingState());

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

    final failureOrSingleQuestion = await getSingleQuestion(
      GetSingleQuestionParams(id: event.id),
    );

    failureOrSingleQuestion.fold(
      (failure) {
        emit(GetSingleQuestionLoadingError(
          message: mapFailureToMessage(failure),
        ));
      },
      (singleQuestion) {
        emit(GetSingleQuestionLoadedState(singleQuestion: singleQuestion));
      },
    );
  }
}
