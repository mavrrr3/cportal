import 'dart:async';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc() : super(NavigationBarState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<NavigationBarEventImpl>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _onEvent(
    NavigationBarEventImpl event,
    Emitter emit,
  ) async {
    emit(NavigationBarState(currentIndex: event.index));
    debugPrint('Отработал эвент: $event');
  }
}
