import 'package:equatable/equatable.dart';

abstract class MainSearchEvent extends Equatable {
  const MainSearchEvent();

  @override
  List<Object?> get props => [];
}

class MainSearch extends MainSearchEvent {
  final String searchQuery;

  const MainSearch(this.searchQuery);
  @override
  List<Object?> get props => [searchQuery];
}
