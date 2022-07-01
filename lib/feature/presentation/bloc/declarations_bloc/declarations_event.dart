import 'package:equatable/equatable.dart';

abstract class DeclarationsEvent extends Equatable {
  const DeclarationsEvent();

  @override
  List<Object> get props => [];
}

class FetchDeclarationsEvent extends DeclarationsEvent {
  const FetchDeclarationsEvent();

  @override
  List<Object> get props => [];
}

class SearchDeclarationsEvent extends DeclarationsEvent {
  final String query;

  const SearchDeclarationsEvent({required this.query});

  @override
  List<Object> get props => [query];
}
