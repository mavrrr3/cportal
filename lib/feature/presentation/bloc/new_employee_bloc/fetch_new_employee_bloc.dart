import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_new_employee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class FetchNewEmployeeBloc
    extends Bloc<FetchNewEmployeeEvent, FetchNewEmployeeState> {
  final INewEmployeeRepository repository;

  FetchNewEmployeeBloc({
    required this.repository,
  }) : super(NewEmployeeEmptyState()) {
    on<FetchNewEmployeeEvent>((event, emit) async {
      emit(const NewEmployeeLoading());

      final failureOrNewEmployeeSlides =
          await repository.fetchNewEmployeeOnboardingSlides();

      failureOrNewEmployeeSlides.fold(failureToMessage,
          (slides) => emit(NewEmployeeLoaded(slides: slides)));
    });
  }
}

String failureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Ошибка на сервере';
    case CacheFailure:
      return 'Ошибка обработки кэша';
    default:
      return 'Unexpected Error';
  }
}

class FetchNewEmployeeEvent extends Equatable {
  const FetchNewEmployeeEvent();
  @override
  List<Object?> get props => [];
}

abstract class FetchNewEmployeeState extends Equatable {
  const FetchNewEmployeeState();

  @override
  List<Object?> get props => [];
}

class NewEmployeeEmptyState extends FetchNewEmployeeState {}

class NewEmployeeLoading extends FetchNewEmployeeState {
  const NewEmployeeLoading();

  @override
  List<Object?> get props => [];
}

class NewEmployeeLoaded extends FetchNewEmployeeState {
  final List<NewEmployeeEntity> slides;

  const NewEmployeeLoaded({required this.slides});

  @override
  List<Object?> get props => [slides];
}

class NewEmployeeLoadingError extends FetchNewEmployeeState {
  final String message;

  const NewEmployeeLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
