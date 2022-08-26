
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'description_enum.g.dart';

@HiveType(typeId: 18)
enum DescriptionEnum {
  @HiveField(0)
  @JsonValue('Стандартный')
  def,

  @HiveField(1)
  @JsonValue('Задача')
  task,

  @HiveField(2)
  @JsonValue('Истек срок')
  expired,

}
