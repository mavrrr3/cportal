import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainSearchState extends Equatable {
  const MainSearchState();

  @override
  List<Object?> get props => [];
}

class MainSearchEmpty extends MainSearchState {
  @override
  List<Object?> get props => [];
}

class MainSearchLoading extends MainSearchState {
  final List<MainSearchEntity> oldSearchList;
  final bool isFirstFetch;

  const MainSearchLoading(this.oldSearchList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldSearchList];
}

class MainSearchLoaded extends MainSearchState {
  final List<MainSearchEntity> searchList;

  const MainSearchLoaded(this.searchList);

  @override
  List<Object?> get props => [searchList];
}

class MainSearchError extends MainSearchState {
  final String message;

  const MainSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
