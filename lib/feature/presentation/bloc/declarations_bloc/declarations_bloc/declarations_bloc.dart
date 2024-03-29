import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/fetch_declarations_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/search_declaration_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsBloc extends Bloc<DeclarationsEvent, DeclarationsState> {
  final FetchDeclarationsUseCase fetchDeclarations;
  final SearchDeclarationUseCase searchDeclarations;

  int page = 1;

  DeclarationsBloc({
    required this.fetchDeclarations,
    required this.searchDeclarations,
  }) : super(DeclarationsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchDeclarationsEvent>(
      _onFetch,
      transformer: bloc_concurrency.droppable(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchDeclarationsEvent event,
    Emitter emit,
  ) async {
    List<DeclarationCardEntity> oldDeclarations = [];
    if (event.isFirstFetch) {
      page = 1;
    }
    if (state is DeclarationsLoadedState && !event.isFirstFetch) {
      oldDeclarations = (state as DeclarationsLoadedState).declarations;
    }

    emit(DeclarationsLoadingState(
      oldDeclarations,
      isFirstFetch: event.isFirstFetch,
    ));

    void loadingDeclarations(List<DeclarationCardEntity> declarationEntity) {
      page++;

      final declarationsList =
          (state as DeclarationsLoadingState).oldDeclarations;

      // ignore: cascade_invocations
      declarationsList.addAll(declarationEntity);
      log('Загрузилось ${declarationsList.length} заявлений');

      emit(DeclarationsLoadedState(declarations: declarationsList));
    }

    final failureOrDeclarations = await fetchDeclarations(
      FetchDeclarationsParams(page: page),
    );

    failureOrDeclarations.fold(
      _mapFailureToMessage,
      loadingDeclarations,
    );

    debugPrint('Отработал эвент: $event');
  }

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
}
