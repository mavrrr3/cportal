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

enum DeclarationStatusEnum { done, inProcess, declined }

DeclarationStatusEnum getDeclarationStepStatus({required String status}) {
  switch (status) {
    case 'Одобрено':
      return DeclarationStatusEnum.done;
    case 'В процессе':
      return DeclarationStatusEnum.inProcess;
    default:
      return DeclarationStatusEnum.declined;
  }
}
