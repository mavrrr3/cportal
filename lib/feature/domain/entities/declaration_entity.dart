import 'package:equatable/equatable.dart';

class DeclarationEntity extends Equatable {
  final String title;
  final String svgPath;
  final String date;
  final String number;
  final String status;

  const DeclarationEntity({
    required this.title,
    required this.svgPath,
    required this.date,
    required this.number,
    required this.status,
  });

  @override
  List<Object?> get props => [title, svgPath, date, number, status];
}
