import 'dart:async';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<NavBarEventImpl>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _onEvent(
    NavBarEventImpl event,
    Emitter emit,
  ) async {
    emit(NavBarState(currentIndex: event.index));
    debugPrint('Отработал эвент: ' + event.toString());
  }
}
