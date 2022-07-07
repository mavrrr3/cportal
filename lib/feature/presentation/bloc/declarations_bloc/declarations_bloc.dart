import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/fetch_declarations_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/get_single_declaration_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/search_declaration_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsBloc extends Bloc<DeclarationsEvent, DeclarationsState> {
  final FetchDeclarationsUseCase fetchDeclarations;
  final GetSingleDeclarationUseCase fetchDeclarationInfo;
  final SearchDeclarationUseCase searchDeclarations;
  DeclarationsBloc({
    required this.fetchDeclarations,
    required this.fetchDeclarationInfo,
    required this.searchDeclarations,
  }) : super(DeclarationsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchDeclarationsEvent>(
      _onFetch,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchDeclarationsEvent event,
    Emitter emit,
  ) async {
    emit(DeclarationsLoadingState());
    emit(DeclarationsLoadedState(
      doneDeclarations: _doneDeclorations(mockDeclarations),
      inProgressDeclarations: _inProgressDeclorations(mockDeclarations),
    ));
    debugPrint('Отработал эвент: $event');
  }

  List<DeclarationEntity> _doneDeclorations(List<DeclarationEntity> items) =>
      items.where((declaration) => declaration.status != 'обработка').toList();

  List<DeclarationEntity> _inProgressDeclorations(List<DeclarationEntity> items) =>
      items.where((declaration) => declaration.status == 'обработка').toList();
}
