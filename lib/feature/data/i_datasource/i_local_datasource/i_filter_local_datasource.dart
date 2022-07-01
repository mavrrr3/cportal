import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';

abstract class IFilterLocalDataSource {
  /// Извлекаем [FilterResponseModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<FilterResponseModel> fetchFiltersFromCache(FilterType type);

  /// Сохраняем [FilterResponseModel] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> filtersToCache(FilterResponseModel filters, FilterType type);
}
