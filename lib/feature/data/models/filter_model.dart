import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:hive/hive.dart';

part 'filter_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields
@HiveType(typeId: 7)
class FilterModel extends FilterEntity {
  @HiveField(0)
  final String headline;

  @HiveField(1)
  final bool isActive;

  @HiveField(2)
  final List<FilterItemModel> items;

  const FilterModel({
    required this.headline,
    required this.items,
    this.isActive = false,
  }) : super(
          headline: headline,
          items: items,
          isActive: isActive,
        );

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        headline: json['headline'] as String,
        isActive: false,
        items: List<FilterItemModel>.from(
          json['items']
                  .map((dynamic x) => FilterItemModel.fromJson(x as String))
              as Iterable<dynamic>,
        ),
      );
}

@HiveType(typeId: 8)
class FilterItemModel extends FilterItemEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isActive;

  const FilterItemModel({
    required this.name,
    this.isActive = false,
  }) : super(
          name: name,
          isActive: isActive,
        );

  factory FilterItemModel.fromJson(String title) => FilterItemModel(
        name: title,
        isActive: false,
      );
}

@HiveType(typeId: 11)
class FilterResponseModel extends FilterResponseEntity {
  @HiveField(0)
  final List<FilterModel> filters;

  const FilterResponseModel({
    required this.filters,
  }) : super(
          filters: filters,
        );

  factory FilterResponseModel.fromJson(Map<String, dynamic> json) =>
      FilterResponseModel(
        filters: List<FilterModel>.from(
          json['response'].map((dynamic x) =>
                  FilterModel.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );
}
