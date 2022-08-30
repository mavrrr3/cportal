import 'package:equatable/equatable.dart';

class TaskDocumentEntity extends Equatable {
  final String title;
  final String file;

  const TaskDocumentEntity({
    required this.title,
    required this.file,
  });

  @override
  List<Object?> get props => [title, file];
}
