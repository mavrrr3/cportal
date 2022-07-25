class DeclarationEntity {
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
}

 const List<DeclarationEntity> mockDeclarations = [
  DeclarationEntity(
    title: 'Заявление на отпуск',
    svgPath: 'assets/icons/fly_vocation.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'обработка',
  ),
  DeclarationEntity(
    title: 'Заявление на командировку',
    svgPath: 'assets/icons/calendar.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'одобрено',
  ),
  DeclarationEntity(
    title: 'Заявление на пропуск',
    svgPath: 'assets/icons/lock.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'обработка',
  ),
  DeclarationEntity(
    title: 'Заявление на расчетный листок',
    svgPath: 'assets/icons/pay_list.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'одобрено',
  ),
  DeclarationEntity(
    title: 'Заявление на тех. поддержку/IT',
    svgPath: 'assets/icons/support.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'отклонено',
  ),
  DeclarationEntity(
    title: 'Заявление на тех. поддержку/IT',
    svgPath: 'assets/icons/support.svg',
    date: '17 августа 2022 15:34:56',
    number: '#И213212111',
    status: 'одобрено',
  ),
];
