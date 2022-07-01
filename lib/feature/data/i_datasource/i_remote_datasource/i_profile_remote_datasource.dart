import 'package:cportal_flutter/feature/data/models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<ProfileModel> getSingleProfile(String id, {bool isMyProfile = false});

  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<List<ProfileModel>> searchProfiles(String query);
}
