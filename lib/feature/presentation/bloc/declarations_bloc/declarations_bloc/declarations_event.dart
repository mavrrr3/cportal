import 'package:equatable/equatable.dart';

abstract class DeclarationsEvent extends Equatable {
  const DeclarationsEvent();

  @override
  List<Object> get props => [];
}

class FetchDeclarationsEvent extends DeclarationsEvent {
  final bool isFirstFetch;

  const FetchDeclarationsEvent({this.isFirstFetch = false});

  @override
  List<Object> get props => [isFirstFetch];
}

class SearchDeclarationsEvent extends DeclarationsEvent {
  final String query;

  const SearchDeclarationsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class ChangeLastRenderedDate extends DeclarationsEvent {
  final DateTime newDate;

  const ChangeLastRenderedDate({required this.newDate});

  @override
  List<Object> get props => [newDate];
}
