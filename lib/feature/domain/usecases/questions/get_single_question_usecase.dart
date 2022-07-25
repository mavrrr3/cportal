import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class GetSingleQuestionUseCase
    extends IUseCase<ArticleEntity, GetSingleQuestionParams> {
  final INewsRepository repository;

  GetSingleQuestionUseCase(this.repository);

  @override
  Future<Either<Failure, ArticleEntity>> call(
    GetSingleQuestionParams params,
  ) async =>
      repository.getSingleQuestion(params.id);
}

class GetSingleQuestionParams extends Equatable {
  final String id;

  const GetSingleQuestionParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
