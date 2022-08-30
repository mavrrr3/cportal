import 'dart:convert';

import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_new_employee_remote_datasource.dart';

import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class NewEmployeeRemoteDataSource implements INewEmployeeRemoteDataSource {
  const NewEmployeeRemoteDataSource();

  @override
  Future<List<NewEmployeeModel>> fetchNewEmployeeOnboardingSlides() async {
    try {
      final employeeMap = jsonDecode(jsonEmployee) as Map<String, dynamic>;

      return List<NewEmployeeModel>.from(
        employeeMap['Content'].map((dynamic x) => NewEmployeeModel.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>,
      );
    } on ServerException {
      throw ServerFailure();
    }
  }
}

const String jsonEmployee = '''
{
    "Content": [
        {
            "title": "Как общаться с коллегами?",
            "description": "Сегодня Вас включат в группу сотрудников Новосталь-М в WhatsApp.",
            "image": "assets/img/onboarding/1.svg"
        },
        {
            "title": "Обязательно для ознакомления!",
            "description": "Сегодня Вам будет назначен курс «Обучение по информационной безопасности», который Вам будет необходимо пройти в течение 2-х недель с даты приема.",
            "image": "assets/img/onboarding/2.svg"
        },
        {
            "title": "Любите читать?",
            "description": "В ближайшее время Вы будете подключены к электронной библиотеке Компании.",
            "image": "assets/img/onboarding/3.svg"
        },
        {
            "title": "Изучайте иностранные языки",
            "description": "В нашей компании проходят курсы по английскому и испанскому языкам. Вы можете присоединиться  к коллегам, изучающих иностранные языки,  для этого Вам нужно обратиться к сотруднику HR. Обучение языкам проходит за счет компании.",
            "image": "assets/img/onboarding/4.svg"
        },
        {
            "title": "Голодным не останетесь",
            "description": "Компания предоставляет сотрудникам бесплатные обеды.",
            "image": "assets/img/onboarding/5.svg"
        },
        {
            "title": "Как получить ДМС?",
            "description": "После прохождения испытательного срока Вам будет оформлен полис ДМС и направлен страховой компанией на почту.",
            "image": "assets/img/onboarding/6.png",
            "isVector": false
        },
        {
            "title": "Всегда рады ответить на вопросы",
            "description": "Дирекция по управлению персоналом",
            "image": "assets/img/onboarding/7.svg"
        }
    ]
}''';
