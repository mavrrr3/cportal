class DeclarationEntity {
  final String id;
  final String title;
  final DateTime date;
  final String status;
  final String icon;

  const DeclarationEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.icon,
  });
}

final List<DeclarationEntity> mockDeclarations = [
  DeclarationEntity(
    title: 'Заявление на отпуск',
    icon: 'assets/icons/fly_vocation.svg',
    date: DateTime(0, 0, 0, 0),
    id: '#И213212111',
    status: 'обработка',
  ),
  DeclarationEntity(
    title: 'Заявление на командировку',
    icon: 'assets/icons/calendar.svg',
    date: DateTime(0, 0, 0, 0),
    id: '#И213212111',
    status: 'одобрено',
  ),
  DeclarationEntity(
    title: 'Заявление на пропуск',
    icon: 'assets/icons/lock.svg',
    date: DateTime(0, 0, 0, 0),
    id: '#И213212111',
    status: 'обработка',
  ),
  DeclarationEntity(
    title: 'Заявление на расчетный листок',
    icon: 'assets/icons/pay_list.svg',
    date: DateTime(0, 0, 0, 0),
    id: '#И213212111',
    status: 'одобрено',
  ),
  DeclarationEntity(
    title: 'Заявление на тех. поддержку/IT',
    icon: 'assets/icons/support.svg',
    date: DateTime(0, 0, 0, 0),
    id: '#И213212111',
    status: 'отклонено',
  ),
  DeclarationEntity(
    title: 'Заявление на тех. поддержку/IT',
    icon: 'assets/icons/support.svg',
    date: DateTime(0, 0, 0, 0),
    id: '#И213212111',
    status: 'одобрено',
  ),
];
