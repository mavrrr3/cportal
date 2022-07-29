import 'dart:async';

import 'package:cportal_flutter/common/util/map_failure_to_message.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search/main_search_add_to_memory_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search/main_search_get_from_memory_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search/main_search_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class MainSearchBloc extends Bloc<MainSearchEvent, MainSearchState> {
  final MainSearchUseCase search;
  final MainSearchAddToMemoryUseCase addToMemory;
  final MainSearchGetFromMemoryUseCase getFromMemory;

  MainSearchBloc(this.search, this.addToMemory, this.getFromMemory)
      : super(MainSearchEmpty()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<MainSearch>(
      _onSearch,
      transformer: bloc_concurrency.sequential(),
    );
    on<MainSearchAdd>(
      _onMemorize,
      transformer: bloc_concurrency.sequential(),
    );
    on<GetMainSearch>(
      _getFromMemory,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr _onSearch(
    MainSearch event,
    Emitter emit,
  ) async {
    emit(const MainSearchLoading());
    final failureOrSearch =
        await search(MainSearchParams(query: event.searchQuery));
    failureOrSearch.fold(
      mapFailureToMessage,
      (searchList) {
        emit(MainSearchLoaded(searchList));
      },
    );
  }

  FutureOr _getFromMemory(
    GetMainSearch _,
    Emitter emit,
  ) async {
    emit(const MainSearchLoading());
    final failureOrSearch = await getFromMemory();
    failureOrSearch.fold(
      mapFailureToMessage,
      (searchList) {
        emit(MainSearchLoaded(searchList!));
      },
    );
  }

  FutureOr _onMemorize(
    MainSearchAdd event,
    Emitter _,
  ) async {
    final failureOrVoid = await addToMemory(event.searchEntity);

    failureOrVoid.fold(
      mapFailureToMessage,
      (success) {},
    );
  }
}
