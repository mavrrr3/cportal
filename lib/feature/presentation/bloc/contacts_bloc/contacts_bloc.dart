import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/contacts/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/profile/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/contacts/search_contacts_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContacts;
  final GetSingleProfileUseCase fetchProfile;
  final SearchContactsUseCase searchContacts;
  int page = 1;

  ContactsBloc({
    required this.fetchContacts,
    required this.fetchProfile,
    required this.searchContacts,
  }) : super(ContactsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchContactsEvent>(
      _onFetch,
      transformer: bloc_concurrency.sequential(),
    );
    on<SearchContactsEvent>(
      _onSearchContacts,
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

  FutureOr<void> _onSearchContacts(
    SearchContactsEvent event,
    Emitter emit,
  ) async {
    if (state is ContactsLoadedState) {
      final favorites = (state as ContactsLoadedState).favorites;
      final failureOrContacts =
          await searchContacts(SearchContactsParams(query: event.query));

      failureOrContacts.fold(
        _mapFailureToMessage,
        (contacts) {
          emit(ContactsLoadedState(contacts: contacts, favorites: favorites));
        },
      );
    }
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
