import 'dart:developer';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/onboarding_datasource/onboarding_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/onboarding_model.dart';
import 'package:dio/dio.dart';

abstract class IOnboardingRemoteDataSource {
  /// Обращается к эндпойнту .....
  /// Возвращает [OnboardingModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<OnboardingModel> fetchOnboarding();
}

class OnboardingRemoteDataSource implements IOnboardingRemoteDataSource {
  final IOnboardingLocalDataSource localDatasource;
  final Dio dio;

  OnboardingRemoteDataSource(
    this.localDatasource,
    this.dio,
  );

  @override
  Future<OnboardingModel> fetchOnboarding() async {
    try {
      log('OnboardingRemoteDataSource $response');
      await localDatasource.onboardingToCache(response);

      return response;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

const OnboardingModel response = OnboardingModel(
  onboardingDuration: 1,
  learningCourseDuration: 5,
  pages: [
    OnboardingItemModel(
      header: 'Как общаться\nс коллегами?',
      description: 'Сегодня Вас включат в группу сотрудников Новосталь-М в WhatsApp.',
      image: 'assets/img/onboarding/1.svg',
    ),
    OnboardingItemModel(
      header: 'Обязательно для\nознакомления!',
      description: 'Сегодня Вам будет назначен курс «Обучение по информационной безопасности», который Вам будет необходимо пройти в течение 2-х\nнедель с даты приема.',
      image: 'assets/img/onboarding/2.svg',
    ),
    OnboardingItemModel(
      header: 'Любите читать?',
      description: 'В ближайшее время Вы будете подключены к электронной библиотеке Компании.',
      image: 'assets/img/onboarding/3.svg',
    ),
    OnboardingItemModel(
      header: 'Изучайте\nиностранные языки',
      description: 'В нашей компании проходят курсы по английскому и испанскому языкам. Вы можете присоединиться  к коллегам, изучающих иностранные языки,  для этого Вам нужно обратиться к сотруднику HR. Обучение языкам проходит за счет компании.',
      image: 'assets/img/onboarding/4.svg',
    ),
    OnboardingItemModel(
      header: 'Голодным\nне останетесь',
      description: 'Компания предоставляет сотрудникам бесплатные обеды.',
      image: 'assets/img/onboarding/5.svg',
    ),
    OnboardingItemModel(
      header: 'Как получить ДМС?Как получить ДМС?',
      description: 'После прохождения испытательного срока Вам будет оформлен полис ДМС и направлен страховой компанией на почту.',
      image: 'assets/img/onboarding/6.png',
      isVector: false,
    ),
    OnboardingItemModel(
      header: 'Всегда рады\nответить на вопросы',
      description: 'Дирекция по управлению персоналом',
      image: 'assets/img/onboarding/7.svg',
    ),
  ],
  course: OnboardingItemModel(
    header: 'Погружение в сферу',
    description: 'Для Вашей адаптации Вы можете ознакомиться с курсом\n«Металлургия для металлургов»',
    image: '',
  ),
);
