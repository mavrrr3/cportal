import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_status_enum.g.dart';

@HiveType(typeId: 21)
enum DeclarationStatusEnum {
  @HiveField(0)
  @JsonValue('Стандартный')
  done,

  @HiveField(1)
  @JsonValue('Стандартный')
  inProcess,

  @HiveField(2)
  @JsonValue('Стандартный')
  declined,
}
