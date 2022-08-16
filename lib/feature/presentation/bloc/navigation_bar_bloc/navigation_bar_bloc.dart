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
    on<NavBarChangePageEvent>(
      _changeCurrentIndex,
      transformer: bloc_concurrency.sequential(),
    );
    on<NavBarVisibilityEvent>(
      _changeVisibility,
      transformer: bloc_concurrency.sequential(),
    );
    on<NavBarLoadingEvent>(
      _showLoader,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _changeCurrentIndex(
    NavBarChangePageEvent event,
    Emitter emit,
  ) async {
    emit(NavigationBarState(currentIndex: event.index));
    debugPrint('Отработал эвент: $event');
  }

  FutureOr<void> _changeVisibility(
    NavBarVisibilityEvent event,
    Emitter emit,
  ) async {
    emit(NavigationBarState(isActive: event.isActive));
    debugPrint('Отработал эвент: $event');
  }

  FutureOr<void> _showLoader(
    NavBarLoadingEvent event,
    Emitter emit,
  ) async {
    emit(NavigationBarState(isLoading: event.isLoading));
    debugPrint('Отработал эвент: $event');
  }
}
