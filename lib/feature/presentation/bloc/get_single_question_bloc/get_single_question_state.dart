import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetSingleQuestionState extends Equatable {
  const GetSingleQuestionState();

  @override
  List<Object?> get props => [];
}

class GetSingleQuestionEmptyState extends GetSingleQuestionState {}

class GetSingleQuestionLoadingState extends GetSingleQuestionState {}

class GetSingleQuestionLoadedState extends GetSingleQuestionState {
  final ArticleEntity singleQuestion;
  const GetSingleQuestionLoadedState({required this.singleQuestion});

  @override
  List<Object?> get props => [singleQuestion];
}

class GetSingleQuestionLoadingError extends GetSingleQuestionState {
  final String message;

  const GetSingleQuestionLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
