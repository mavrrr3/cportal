import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
// Временный файл с моками данных на разных страницах, чтобы не засорять основной код.

class Mocks {
  // Контакты.
  static final List<ProfileEntity> contacts = [
    ProfileEntity(
      id: '111',
      externalId: '111',
      firstName: 'Суханенков',
      middleName: 'Владимир',
      lastName: 'Константинович',
      birthday: 'birthday',
      email: 'email',
      photoLink:
          'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png',
      active: true,
      position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов',
      ),
      phone: const [
        PhoneEntity(
          number: '76-56-67',
          suffix: '',
          primary: false,
        ),
        PhoneEntity(
          number: '923 456 67 78',
          suffix: '+7',
          primary: false,
        ),
      ],
      userCreated: 'userCreated',
      dateCreated: DateTime.now(),
      userUpdate: 'userUpdate',
      dateUpdated: DateTime.now(),
    ),
    ProfileEntity(
      id: '111',
      externalId: '111',
      firstName: 'Суханенков',
      middleName: 'Владимир',
      lastName: 'Константинович',
      birthday: 'birthday',
      email: 'email',
      photoLink:
          'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png',
      active: true,
      position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов',
      ),
      phone: const [
        PhoneEntity(
          number: '76-56-67',
          suffix: '',
          primary: false,
        ),
        PhoneEntity(
          number: '923 456 67 78',
          suffix: '+7',
          primary: false,
        ),
      ],
      userCreated: 'userCreated',
      dateCreated: DateTime.now(),
      userUpdate: 'userUpdate',
      dateUpdated: DateTime.now(),
    ),
    ProfileEntity(
      id: '111',
      externalId: '111',
      firstName: 'Суханенков',
      middleName: 'Владимир',
      lastName: 'Константинович',
      birthday: 'birthday',
      email: 'email',
      photoLink:
          'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png',
      active: true,
      position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов',
      ),
      phone: const [
        PhoneEntity(
          number: '76-56-67',
          suffix: '',
          primary: false,
        ),
        PhoneEntity(
          number: '923 456 67 78',
          suffix: '+7',
          primary: false,
        ),
      ],
      userCreated: 'userCreated',
      dateCreated: DateTime.now(),
      userUpdate: 'userUpdate',
      dateUpdated: DateTime.now(),
    ),
  ];

  // Фильтр.
  static final List<FilterEntity> filter = [
    const FilterEntity(
      headline: 'Компания',
      items: [
        FilterItemEntity(name: 'АЭМ3'),
        FilterItemEntity(name: 'Новосталь-М'),
        FilterItemEntity(name: 'Демедия'),
      ],
    ),
    const FilterEntity(
      headline: 'Должность',
      items: [
        FilterItemEntity(name: 'Информационные технологии'),
        FilterItemEntity(name: 'Отдел кадров'),
        FilterItemEntity(name: 'Служба безопасности'),
        FilterItemEntity(name: 'Менеджеры по документообороту'),
        FilterItemEntity(name: 'Отдел мобильной разработки'),
        FilterItemEntity(name: 'Отдел продаж'),
        FilterItemEntity(name: 'Производственный отдел'),
        FilterItemEntity(name: 'Отдел сбыта'),
        FilterItemEntity(name: 'Администрация'),
      ],
    ),
  ];
}
