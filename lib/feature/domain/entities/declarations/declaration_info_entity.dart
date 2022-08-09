import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_data_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_user_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_status_entity.dart';

class DeclarationInfoEntity {
  final String id;
  final String title;
  final String status;
  final double progress;
  final String priority;
  final DeclarationUserEntity initiator;
  final DeclarationUserEntity responsible;
  final List<DeclarationStepEntity> steps;
  final List<DeclarationDataEntity> data;

  DeclarationInfoEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.progress,
    required this.priority,
    required this.initiator,
    required this.responsible,
    required this.steps,
    required this.data,
  });
}

// final DeclarationInfoEntity declarationInfoMock = DeclarationInfoEntity(
//   title: 'Заявление на пропуск',
//   id: '#И213212111',
//   progress: 0.75,
//   priority: 'Высокий',
//   status: Ste,
//   initiator: DeclarationUserEntity(
//     id: '1531231',
//     fullName: 'Кириллова Анна Дмитриевна',
//     position: 'Начальник отдела',
//     image: '',
//   ),
//   responsible: DeclarationUserEntity(
//     id: '1531231',
//     fullName: 'Кириллова Анна Дмитриевна',
//     position: 'Начальник отдела',
//     image: '',
//   ),
//   steps: [
//     DeclarationStepEntity(
//       title: 'Заявка создана',
//       date: DateTime(2022, 7, 1, 15, 21, 42),
//       status: 'StepStatus.done',
//     ),
//     DeclarationStepEntity(
//       title: 'Принято Службой безопасности',
//       date: DateTime(2022, 7, 3, 11, 15, 38),
//       status: 'StepStatus.done',
//     ),
//     DeclarationStepEntity(
//       title: 'На проверке службой безопасности',
//       date: DateTime(2022, 7, 4, 17, 42, 12),
//       status: 'StepStatus.inProgress',
//     ),
//   ],
//   data: [
//     DeclarationDataEntity(
//       title: 'ФИО посетителя',
//       description: 'Игумнов Тимофей Андреевич',
//     ),
//     DeclarationDataEntity(
//       title: 'Паспортные данные посетителя',
//       description: '45 56 678876',
//     ),
//     DeclarationDataEntity(
//       title: 'Дата визита',
//       description: '12.01.2022',
//     ),
//     DeclarationDataEntity(
//       title: 'Контактный телефон',
//       description: '+7 923 456 67 78',
//     ),
//   ],
// );
