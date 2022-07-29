import 'package:cportal_flutter/core/error/failure.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Ошибка на сервере';
    case CacheFailure:
      return 'Ошибка обработки кэша';
    default:
      return 'Unexpected Error';
  }
}
