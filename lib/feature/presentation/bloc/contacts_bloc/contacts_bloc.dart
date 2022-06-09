import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContacts;
  final GetSingleProfileUseCase fetchProfile;
  int page = 1;

  ContactsBloc({
    required this.fetchContacts,
    required this.fetchProfile,
  }) : super(ContactsEmptyState()) {
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
    List<ProfileEntity> oldContacts = [];
    if (event.isFirstFetch) {
      page = 1;
    }
    if (state is ContactsLoadedState && !event.isFirstFetch) {
      oldContacts = (state as ContactsLoadedState).contacts;
    }

    emit(ContactsLoadingState(oldContacts, isFirstFetch: event.isFirstFetch));
    log('Page $page');
    final failureOrContacts = await fetchContacts(
      FetchContactsParams(page: page),
    );

    void _loadingContacts(ContactsEntity contactsEntity) {
      page++;

      final contactsList = (state as ContactsLoadingState).oldContacts;

      // ignore: cascade_invocations
      contactsList.addAll(contactsEntity.contacts);
      log('Загрузилось ${contactsList.length} контактов');

      emit(ContactsLoadedState(
        contacts: contactsList,
        favorites: contactsEntity.favorites,
      ));
    }

    failureOrContacts.fold(
      _mapFailureToMessage,
      _loadingContacts,
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
