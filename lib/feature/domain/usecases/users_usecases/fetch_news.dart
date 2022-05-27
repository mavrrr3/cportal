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
  Future<Either<Failure, NewsEntity>> call(FetchNewsParams params) async {
    var data = await newsRepository.fetchNews(params.code);

    return data;
  }
}

class FetchNewsParams extends Equatable {
  final String code;

  const FetchNewsParams({required this.code});
  @override
  List<Object?> get props => [code];
}
