import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_enum.g.dart';

@HiveType(typeId: 19)
enum DeclarationEnum {
  @HiveField(0)
  @JsonValue('Стандартный')
  def,

  @HiveField(1)
  @JsonValue('Стандартный')
  task,

  @HiveField(2)
  @JsonValue('Стандартный')
  documents,
}
