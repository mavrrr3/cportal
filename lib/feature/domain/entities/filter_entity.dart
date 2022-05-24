import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FilterEntity extends Equatable {
  final String headline;
  final List<FilterItemEntity> items;
  bool isActive;

  FilterEntity({
    required this.headline,
    required this.items,
    this.isActive = false,
  });

  @override
  List<Object?> get props => [headline, items, isActive];
}

// ignore: must_be_immutable
class FilterItemEntity extends Equatable {
  final String name;
  bool isActive;

  FilterItemEntity({
    required this.name,
    this.isActive = false,
  });

  @override
  List<Object?> get props => [name, isActive];
}
