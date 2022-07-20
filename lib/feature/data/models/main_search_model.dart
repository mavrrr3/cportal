import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_search_model.g.dart';

@JsonSerializable(createToJson: false)
class MainSearchModel {
  final String category;
  final String title;
  final String id;

  MainSearchModel({
    required this.category,
    required this.title,
    required this.id,
  });

  factory MainSearchModel.fromJson(Map<String, dynamic> json) =>
      _$MainSearchModelFromJson(json);

  MainSearchEntity toEntity() {
    return MainSearchEntity(
      id: id,
      category: category,
      title: title,
    );
  }
}
