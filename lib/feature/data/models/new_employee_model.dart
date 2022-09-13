import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:hive/hive.dart';

part 'new_employee_model.g.dart';

// ignore_for_file: overridden_fields
// ignore_for_file: annotate_overrides
@HiveType(typeId: 19)
class NewEmployeeModel extends NewEmployeeEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String image;

  const NewEmployeeModel({
    required this.title,
    required this.description,
    required this.image,
  }) : super(
          title: title,
          description: description,
          image: image,
        );

  factory NewEmployeeModel.fromJson(Map<String, dynamic> json) =>
      NewEmployeeModel(
        title: json['title'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
      );
}

@HiveType(typeId: 20)
class NewEmployeeResponseModel extends NewEmployeeResponseEntity {
  @HiveField(0)
  final int count;
  @HiveField(1)
  final List<NewEmployeeModel> slides;

  const NewEmployeeResponseModel({required this.count, required this.slides})
      : super(
          count: count,
          slides: slides,
        );

  factory NewEmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    return NewEmployeeResponseModel(
      count: json['response']['count'] as int,
      slides: json['response']['items'] != null
          ? List<NewEmployeeModel>.from(json['response']['items'].map(
              (dynamic x) =>
                  NewEmployeeModel.fromJson(x as Map<String, dynamic>),
            ) as Iterable<dynamic>)
          : [],
    );
  }
}
