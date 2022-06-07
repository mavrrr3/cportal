import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContacts;

  ContactsBloc({required this.fetchContacts}) : super(ContactsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchContactsEvent>(
      _onFetch,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchContactsEvent event,
    Emitter emit,
  ) async {
    emit(FetchContactsLoadingState());

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

    final failureOrContacts =
        await fetchContacts(const FetchContactsParams(page: 1));


    failureOrContacts.fold(
      (failure) {
        emit(FetchContactsFetchErrorState(
          message: _mapFailureToMessage(failure),
        ));
      },
      (contacts) {
        emit(FetchContactsLoadedState(data: contacts));
      },
    );

    debugPrint('Отработал эвент: $event');
  }
}
