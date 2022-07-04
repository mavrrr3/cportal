import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class FetchContactsEvent extends ContactsEvent {
  final bool isFirstFetch;

  const FetchContactsEvent({this.isFirstFetch = false});

  @override
  List<Object> get props => [isFirstFetch];
}

class SearchContactsEvent extends ContactsEvent {
  final String query;

  const SearchContactsEvent({required this.query});

  @override
  List<Object> get props => [query];
}
