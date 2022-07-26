import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainSearchBloc extends Bloc<MainSearchEvent, MainSearchState> {
  final MainSearchUseCase search;

  MainSearchBloc(this.search) : super(MainSearchEmpty()) {
    on<MainSearch>(
      (event, emit) async {
        emit(const MainSearchLoading());
        final failureOrSearch =
            await search(MainSearchParams(query: event.searchQuery));
        failureOrSearch.fold(
          _mapFailureToMessage,
          (searchList) {
            emit(MainSearchLoaded(searchList));
          },
        );
      },
    );
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
