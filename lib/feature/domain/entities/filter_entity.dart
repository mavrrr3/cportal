import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:equatable/equatable.dart';

class FilterEntity extends Equatable {
  final String headline;
  final List<FilterItemEntity> items;
  final bool isActive;

  const FilterEntity({
    required this.headline,
    required this.items,
    this.isActive = false,
  });

  FilterEntity copyWith({
    String? headline,
    List<FilterItemEntity>? items,
    bool? isActive,
  }) {
    return FilterEntity(
      headline: headline ?? this.headline,
      items: items ?? this.items,
      isActive: isActive ?? this.isActive,
    );
  }

  bool get changeActivity => !isActive;

  @override
  List<Object?> get props => [headline, items, isActive];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'headline': headline,
        'items': List<dynamic>.from(items.map<dynamic>((x) => (x as FilterItemModel).name)),
      };
}

class FilterItemEntity extends Equatable {
  final String name;
  final bool isActive;

  const FilterItemEntity({
    required this.name,
    this.isActive = false,
  });

  FilterItemEntity copyWith({
    String? name,
    bool? isActive,
  }) {
    return FilterItemEntity(
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  bool get changeActivity => !isActive;

  @override
  List<Object?> get props => [name, isActive];
}

class FilterResponseEntity extends Equatable {
  final List<FilterEntity> filters;

  const FilterResponseEntity({required this.filters});

  @override
  List<Object?> get props => [filters];
}

enum FilterType { contacts, declarations }
