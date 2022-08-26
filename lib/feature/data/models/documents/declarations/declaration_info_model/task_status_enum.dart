import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_status_enum.g.dart';

@HiveType(typeId: 21)
enum TaskStatusEnum {
  @HiveField(0)
  @JsonValue('Ожидание исполнения задачи')
  inProccess,

  @HiveField(1)
  @JsonValue('Просрочил выполнение задачи')
  expired,

  @HiveField(2)
  @JsonValue('Задача исполнена')
  finished,

  @HiveField(3)
  @JsonValue('Задача исполнена с комментарием')
  finishedWithComment,

  @HiveField(4)
  @JsonValue('Заявление не согласовано')
  notAgreed
}
