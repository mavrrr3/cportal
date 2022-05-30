import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:hive/hive.dart';

part 'filter_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields
@HiveType(typeId: 8)
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
}

@HiveType(typeId: 9)
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

  // FilterItemModel copyWith({
  //   String? name,
  //   bool? isActive,
  // }) {
  //   return FilterItemModel(
  //     name: name ?? this.name,
  //     isActive: isActive ?? this.isActive,
  //   );
  // }

  // bool get changeActivity => !isActive;
}
