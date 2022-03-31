import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/get_single_user_usecase.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_user_bloc/get_single_user_event.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_user_bloc/get_single_user_state.dart';

class GetSingleUserBloc extends Bloc<GetSingleUserEvent, GetSingleUserState> {
  final GetSingleUserUseCase getSingleUser;

  GetSingleUserBloc({required this.getSingleUser})
      : super(GetSingleUserEmptyState()) {
    on<GetSingleUserEventImpl>(
      (event, emit) async {
        emit(GetSingleUserLoadingState());

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

        final failureOrUser = await getSingleUser(
          GetSingleUserParams(id: event.id),
        );

        failureOrUser.fold(
          (failure) {
            emit(GetSingleUserLoadingError(
              message: _mapFailureToMessage(failure),
            ));
          },
          (user) {
            emit(GetSingleUserLoadedState(user: user));
          },
        );
      },
    );
  }
}
