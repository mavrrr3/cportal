import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_step_status_enum.g.dart';

@HiveType(typeId: 21)
enum DeclarationStepStatusEnum {
  @HiveField(0)
  @JsonValue('В работе')
  inProcess,

  @HiveField(1)
  @JsonValue('Просрочено')
  expired,

  @HiveField(2)
  @JsonValue('Выполнено')
  completed,

  @HiveField(3)
  @JsonValue('Выполнено с комментарием')
  completedWithComment,

  @HiveField(4)
  @JsonValue('Отклонено')
  declined,
}
