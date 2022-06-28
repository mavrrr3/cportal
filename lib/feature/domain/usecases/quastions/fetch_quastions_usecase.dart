import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchQuastionsUseCase extends IUseCase<NewsEntity, FetchQuastionsParams> {
  final INewsRepository quastionsRepository;

  FetchQuastionsUseCase(this.quastionsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(FetchQuastionsParams params) =>
      quastionsRepository.fetchQuastions(params.page);

  Future<List<String>> fetchQuastionCategories() async {
    return quastionsRepository.fetchCategories();
  }
}

class FetchQuastionsParams extends Equatable {
  final int page;

  const FetchQuastionsParams({required this.page});
  @override
  List<Object?> get props => [page];
}
