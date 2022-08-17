import 'package:equatable/equatable.dart';

class DeclarationStatusEntity extends Equatable {
  final String title;
  final String color;

  const DeclarationStatusEntity({
    required this.title,
    required this.color,
  });

  @override
  List<Object?> get props => [title, color];
}
