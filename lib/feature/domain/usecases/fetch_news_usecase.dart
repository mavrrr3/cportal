import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchNewsUseCase extends IUseCase<NewsEntity, FetchNewsParams> {
  final INewsRepository newsRepository;

  FetchNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(FetchNewsParams params) =>
      newsRepository.fetchNews(params.page, params.category);
}

class FetchNewsParams extends Equatable {
  final int page;
  final String? category;

  const FetchNewsParams({required this.page, required this.category});
  @override
  List<Object?> get props => [page, category];
}
