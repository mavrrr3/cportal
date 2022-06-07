import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProfileModel tProfileModel;

  setUp(() {
    // tProfileModel = ProfileModel(
    //   id: 'A1B2C3D4E5',
    //   externalId: '8877',
    //   firstName: 'Александр',
    //   lastName: 'Дымченко',
    //   middleName: 'Валерьевич',
    //   birthday: '20.11.1984',
    //   email: 'aaa@novostal.ru',
    //   photoLink: '2.jpg',
    //   active: true,
    //   position: const PositionModel(
    //     id: 'a1b2c3d4',
    //     description: 'Начальник отдела',
    //     department: 'Информационные технологии',
    //   ),
    //   phone: const [
    //     PhoneModel(number: '25-425-655', suffix: '033', primary: true),
    //     PhoneModel(number: '987-65-06', suffix: '033', primary: false),
    //   ],
    //   userCreated: 'id_user_created',
    //   dateCreated: DateTime.parse('2022-03-21T14:37:12.068Z'),
    //   userUpdate: 'id_user_updated',
    //   dateUpdated: DateTime.parse('2022-03-21T14:37:12.068Z'),
    // );
  });

  test('should be a subclass of [ProfileEntity] entity', () async {
    // Assert.
    // expect(tProfileModel, isA<ProfileEntity>());
  });

  test(
    'should return valid [ProfileModel] model',
    () async {
      // Arrange.
      const String stringProfile = '''
                          {
"id": "A1B2C3D4E5",
"external_id": "8877",
"first_name": "Александр",
"last_name": "Дымченко",
"middle_name": "Валерьевич",
"birthday": "20.11.1984",
"email": "aaa@novostal.ru",
"photo_link": "2.jpg",
"active": true,
"position": {
"id": "a1b2c3d4",
"description": "Начальник отдела",
"department": "Информационные технологии"
},
"phone": [
{
"number": "25-425-655",
"suffix": "033",
"primary": true
},
{
"number": "987-65-06",
"suffix": "033",
"primary": false
}
],
"user_created": "id_user_created",
"date_created": "2022-03-21T14:37:12.068Z",
"user_update": "id_user_updated",
"date_updated": "2022-03-21T14:37:12.068Z"
}''';

      // Act..
      final ProfileModel profileModelFromString =
          profileModelFromJson(stringProfile);

      // Assert.
      // expect(profileModelFromString, equals(tProfileModel));
    },
  );

  test('should return ', () async {
    // Arrange.
    const String expectedString =
        r'{"id":"A1B2C3D4E5","external_id":"8877","first_name":"Александр","last_name":"Дымченко","middle_name":"Валерьевич","birthday":"20.11.1984","email":"aaa@novostal.ru","photo_link":"2.jpg","active":true,"position":{"id":"a1b2c3d4","description":"Начальник отдела","department":"Информационные технологии"},"phone":["{\"number\":\"25-425-655\",\"suffix\":\"033\",\"primary\":true}","{\"number\":\"987-65-06\",\"suffix\":\"033\",\"primary\":false}"],"user_created":"id_user_created","date_created":"2022-03-21T14:37:12.068Z","user_update":"id_user_updated","date_updated":"2022-03-21T14:37:12.068Z"}';

    // Act.
    // final result = profileModelToJson(tProfileModel);

    // Assert.
    // expect(result, equals(expectedString));
  });
}
