import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_onboarding_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/onboarding_bloc/onboarding_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/onboarding_bloc/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final FetchOnboardingUseCase fetchOnboarding;

  OnboardingBloc({required this.fetchOnboarding})
      : super(OnboardingEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchOnboardingEvent>(
      _onFetch,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchOnboardingEvent event,
    Emitter emit,
  ) async {
    emit(OnboardingLoadingState());

    final failureOrOnboarding = await fetchOnboarding();

    failureOrOnboarding.fold(
      (failure) {
        emit(OnboardingLoadingErrorState(
          message: _mapFailureToMessage(failure),
        ));
      },
      (onboarding) {
        emit(OnboardingLoadedState(onboarding: onboarding));
      },
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
