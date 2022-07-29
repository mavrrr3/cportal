import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
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

class MainSearchAdd extends MainSearchEvent {
  final MainSearchEntity searchEntity;

  const MainSearchAdd(this.searchEntity);
  @override
  List<Object?> get props => [searchEntity];
}

class GetMainSearch extends MainSearchEvent {
  const GetMainSearch();
  @override
  List<Object?> get props => [];
}
