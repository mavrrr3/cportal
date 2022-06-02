import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

class ContactsEmptyState extends ContactsState {}

class FetchContactsLoadingState extends ContactsState {}

class FetchContactsLoadedState extends ContactsState {
  final ContactsEntity data;

  const FetchContactsLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchContactsFetchErrorState extends ContactsState {
  final String message;

  const FetchContactsFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
