// Инам для выдачи NewsEntity Новости, Вопросы, Справочник.
enum NewsCodeEnum { news, quastion, catalog }

String newsCode(NewsCodeEnum codeEnum) {
  switch (codeEnum) {
    case NewsCodeEnum.news:
      return 'NEWS';
    case NewsCodeEnum.quastion:
      return 'QUASTION';
    default:
      return 'CATALOG';
  }
}
