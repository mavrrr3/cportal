import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetSingleNewsState extends Equatable {
  const GetSingleNewsState();

  @override
  List<Object?> get props => [];
}

class GetSingleNewsEmptyState extends GetSingleNewsState {}

class GetSingleNewsLoadingState extends GetSingleNewsState {}

class GetSingleNewsLoadedState extends GetSingleNewsState {
  final ArticleEntity singleNews;
  const GetSingleNewsLoadedState({required this.singleNews});

  @override
  List<Object?> get props => [singleNews];
}

class GetSingleNewsLoadingError extends GetSingleNewsState {
  final String message;

  const GetSingleNewsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
