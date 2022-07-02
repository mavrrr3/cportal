import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchQuestionsByCategoryUseCase
    extends IUseCase<NewsEntity, FetchQuestionsByCategoryParams> {
  final INewsRepository newsRepository;

  FetchQuestionsByCategoryUseCase(this.newsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(
    FetchQuestionsByCategoryParams params,
  ) =>
      newsRepository.fetchQuestionsByCategory(params.page, params.category);
}

class FetchQuestionsByCategoryParams extends Equatable {
  final int page;
  final String category;

  const FetchQuestionsByCategoryParams({
    required this.page,
    required this.category,
  });
  @override
  List<Object?> get props => [page, category];
}
