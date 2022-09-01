import 'package:equatable/equatable.dart';

class DeclarationDataEntity extends Equatable {
  final String title;
  final String value;

  const DeclarationDataEntity({
    required this.title,
    required this.value,
  });

  @override
  List<Object?> get props => [title, value];
}
