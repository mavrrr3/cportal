import 'package:equatable/equatable.dart';

class DeclarationDocumentEntity extends Equatable {
  final String title;
  final String file;

  const DeclarationDocumentEntity({
    required this.title,
    required this.file,
  });

  @override
  List<Object?> get props => [title, file];
}
