import 'package:equatable/equatable.dart';

class NewEmployeeEntity extends Equatable {
  final String title;
  final String description;
  final String image;

  const NewEmployeeEntity({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [title, description, image];
}

class NewEmployeeResponseEntity extends Equatable {
  final int count;

  final List<NewEmployeeEntity> slides;

  const NewEmployeeResponseEntity({
    required this.count,
    required this.slides,
  });

  @override
  List<Object?> get props => [count, slides];
}
