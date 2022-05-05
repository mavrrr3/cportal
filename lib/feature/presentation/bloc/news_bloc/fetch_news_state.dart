import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FetchNewsState extends Equatable {
  const FetchNewsState();

  @override
  List<Object?> get props => [];
}

class FetchNewsEmptyState extends FetchNewsState {}

class FetchNewsLoadingState extends FetchNewsState {}

class FetchNewsLoadedState extends FetchNewsState {
  final NewsEntity news;
  final List<String> tabs;
  final int? openedIndex;
  const FetchNewsLoadedState({
    required this.news,
    required this.tabs,
    this.openedIndex,
  });

  @override
  List<Object?> get props => [news];
}

class FetchNewsLoadingError extends FetchNewsState {
  final String message;

  const FetchNewsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
