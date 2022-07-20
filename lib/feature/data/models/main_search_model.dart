import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';

class MainSearchModel extends MainSearchEntity {
  const MainSearchModel({
    required String category,
    required String id,
    required String title,
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
