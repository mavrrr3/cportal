import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchNewsByCategoryUseCase
    extends IUseCase<NewsEntity, FetchNewsByCategoryParams> {
  final INewsRepository newsRepository;

  FetchNewsByCategoryUseCase(this.newsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(FetchNewsByCategoryParams params) =>
      newsRepository.fetchNewsByCategory(params.page, params.category);
}

class FetchNewsByCategoryParams extends Equatable {
  final int page;
  final String category;

  const FetchNewsByCategoryParams({required this.page, required this.category});
  @override
  List<Object?> get props => [page, category];
}
