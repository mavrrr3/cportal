// ignore_for_file: overridden_fields

import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:hive/hive.dart';

part 'main_search_model.g.dart';

@HiveType(typeId: 16)
class MainSearchModel extends MainSearchEntity {
  @override
  @HiveField(0)
  final String category;

  @override
  @HiveField(1)
  final String id;

  @override
  @HiveField(2)
  final String title;

  const MainSearchModel({
    required this.category,
    required this.id,
    required this.title,
  }) : super(
          category: category,
          id: id,
          title: title,
        );

  factory MainSearchModel.fromJson(Map<String, dynamic> json) =>
      MainSearchModel(
        category: json['category'] as String,
        id: json['id'] as String,
        title: json['title'] as String,
      );
}

class MainSearchDeserializeModel {
  final List<MainSearchModel> searchList;

  const MainSearchDeserializeModel({
    required this.searchList,
  });

  factory MainSearchDeserializeModel.fromJson(Map<String, dynamic> json) {
    return MainSearchDeserializeModel(
      searchList: json['response']['items'] != null
          ? List<MainSearchModel>.from(json['response']['items'].map(
              (dynamic x) =>
                  MainSearchModel.fromJson(x as Map<String, dynamic>),
            ) as Iterable<dynamic>)
          : [],
    );
  }
}
