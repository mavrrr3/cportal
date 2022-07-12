import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchQuestionsUseCase extends IUseCase<NewsEntity, FetchQuestionsParams> {
  final INewsRepository questionsRepository;

  FetchQuestionsUseCase(this.questionsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(FetchQuestionsParams params) =>
      questionsRepository.fetchQuestions(params.page);

  Future<List<String>> fetchQuestionCategories() async {
    return questionsRepository.fetchQuestionCategories();
  }
}

class FetchQuestionsParams extends Equatable {
  final int page;

  const FetchQuestionsParams({required this.page});
  @override
  List<Object?> get props => [page];
}
