import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:equatable/equatable.dart';

class TasksResponseEntity extends Equatable {
  final int total;
  final List<TaskCardEntity> items;

  const TasksResponseEntity({
    required this.total,
    required this.items,
  });

  @override
  List<Object?> get props => [total, items];
}
