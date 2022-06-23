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


// ignore: must_be_immutable
// class FilterItemEntity extends Equatable {
//   final String name;
//   bool isActive;

//   FilterItemEntity({
//     required this.name,
//     this.isActive = false,
//   });

//   @override
//   List<Object?> get props => [name, isActive];
// }
