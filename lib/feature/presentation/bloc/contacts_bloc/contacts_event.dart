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

class FetchContactProfileEvent extends ContactsEvent {
  final int id;

  const FetchContactProfileEvent({required this.id});

  @override
  List<Object> get props => [id];
}
