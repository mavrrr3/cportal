import 'package:equatable/equatable.dart';

class MainSearchEntity extends Equatable {
  final String category;
  final String title;
  final String id;

  const MainSearchEntity({
    required this.category,
    required this.title,
    required this.id,
  });

  @override
  List<Object?> get props => [category, title, id];
}
