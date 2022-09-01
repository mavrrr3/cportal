import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/get_single_declaration_usecase.dart';

import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleDeclarationBloc
    extends Bloc<SingleDeclarationEvent, SingleDeclarationState> {
  final GetSingleDeclarationUseCase getSingleDeclaration;

  SingleDeclarationBloc({
    required this.getSingleDeclaration,
  }) : super(SingleDeclarationEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<GetSingleDeclarationEvent>(
      _onFetch,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    GetSingleDeclarationEvent event,
    Emitter emit,
  ) async {
    emit(SingleDeclarationLoadingState());
    final failureOrDeclaration = await getSingleDeclaration(
      GetSingleDeclarationParams(id: event.id, isTask: event.isTask),
    );
    void _loadingDeclaration(DeclarationInfoEntity declarationEntity) {
      emit(SingleDeclarationLoadedState(declaration: declarationEntity));
    }

    failureOrDeclaration.fold(
      _mapFailureToMessage,
      _loadingDeclaration,
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
