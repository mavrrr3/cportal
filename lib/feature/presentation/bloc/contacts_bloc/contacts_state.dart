import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

class ContactsEmptyState extends ContactsState {}

class ContactsLoadingState extends ContactsState {
  final List<ProfileEntity> oldContacts;
  final bool isFirstFetch;

  const ContactsLoadingState(
    this.oldContacts, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldContacts, isFirstFetch];
}

class ContactsLoadedState extends ContactsState {
  final List<ProfileEntity> contacts;
  final List<ProfileEntity> favorites;

  const ContactsLoadedState({
    required this.contacts,
    required this.favorites,
  });

  @override
  List<Object?> get props => [contacts, favorites];
}

class ContactsFetchErrorState extends ContactsState {
  final String message;

  const ContactsFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
