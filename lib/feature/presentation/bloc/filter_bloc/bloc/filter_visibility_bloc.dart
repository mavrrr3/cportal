// ignore_for_file: avoid_function_literals_in_foreach_calls, unnecessary_parenthesis

import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterVisibilityBloc extends Bloc<FilterEvent, FilterVisibilityState> {
  FilterVisibilityBloc() : super(const FilterVisibilityState(isActive: false)) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FilterChangeVisibilityEvent>(
      changeVisibility,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Отвечает за появление фильтра.
  FutureOr<void> changeVisibility(
    FilterChangeVisibilityEvent event,
    Emitter emit,
  ) async {
    emit(FilterVisibilityState(isActive: event.isVisible));

    debugPrint('Отработал эвент: $event');
  }
}
