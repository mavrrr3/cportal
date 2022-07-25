import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class GetSingleNewsUseCase
    extends IUseCase<ArticleEntity, GetSingleNewsParams> {
  final INewsRepository repository;

  GetSingleNewsUseCase(this.repository);

  @override
  Future<Either<Failure, ArticleEntity>> call(
    GetSingleNewsParams params,
  ) async =>
      repository.getSingleNews(params.id);
}

class GetSingleNewsParams extends Equatable {
  final String id;

  const GetSingleNewsParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
