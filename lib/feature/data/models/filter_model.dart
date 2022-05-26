import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:hive/hive.dart';

part 'filter_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields
@HiveType(typeId: 8)
class FilterModel extends FilterEntity {
  const FilterModel({
    required this.headline,
    required this.items,
    this.isActive = false,
  }) : super(
          headline: headline,
          items: items,
          isActive: isActive,
        );

  @HiveField(0)
  final String headline;

  @HiveField(1)
  final bool isActive;

  @HiveField(2)
  final List<FilterItemEntity> items;
}

@HiveType(typeId: 9)
class FilterItemModel extends FilterItemEntity {
  const FilterItemModel({
    required this.name,
    this.isActive = false,
  }) : super(
          name: name,
          isActive: isActive,
        );

  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isActive;
}
