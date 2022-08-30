import 'package:equatable/equatable.dart';

class TaskParametrEntity extends Equatable {
  final String title;
  final String value;

  const TaskParametrEntity({
    required this.title,
    required this.value,
  });

  @override
  List<Object?> get props => [title, value];
}
