import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchQuastionsByCategoryUseCase
    extends IUseCase<NewsEntity, FetchQuastionsByCategoryParams> {
  final INewsRepository newsRepository;

  FetchQuastionsByCategoryUseCase(this.newsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(
    FetchQuastionsByCategoryParams params,
  ) =>
      newsRepository.fetchNewsByCategory(params.page, params.category);
}

class FetchQuastionsByCategoryParams extends Equatable {
  final int page;
  final String category;

  const FetchQuastionsByCategoryParams({
    required this.page,
    required this.category,
  });
  @override
  List<Object?> get props => [page, category];
}
