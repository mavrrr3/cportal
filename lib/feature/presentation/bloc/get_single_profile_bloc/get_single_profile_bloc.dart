import 'dart:async';

import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/usecases/profile/get_single_profile_usecase.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class GetSingleProfileBloc extends Bloc<GetSingleProfileEvent, GetSingleProfileState> {
  final GetSingleProfileUseCase getSingleProfile;

  GetSingleProfileBloc({required this.getSingleProfile}) : super(GetSingleProfileEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<GetSingleProfileEventImpl>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr _onEvent(
    GetSingleProfileEventImpl event,
    Emitter emit,
  ) async {
    emit(GetSingleProfileLoadingState());

    String mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    final failureOrUser = await getSingleProfile(
      GetSingleProfileParams(id: event.id, isMyProfile: event.isMyProfile),
    );

    failureOrUser.fold(
      (failure) {
        emit(GetSingleProfileLoadingError(
          message: mapFailureToMessage(failure),
        ));
      },
      (user) {
        emit(GetSingleProfileLoadedState(profile: user));
      },
    );
  }
}
