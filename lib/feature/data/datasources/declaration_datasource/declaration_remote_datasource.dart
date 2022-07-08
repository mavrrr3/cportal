import 'package:cportal_flutter/feature/data/datasources/declaration_datasource/declaration_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/declaration_model.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class IDeclarationRemoteDataSource {
  /// Обращается к эндпойнту .....
  /// Возвращает [List<DeclarationEntity>]
  /// Пробрасывает ошибки через [ServerException]
  Future<List<DeclarationModel>> fetchDeclarations(int page);

  /// Обращается к эндпойнту .....
  /// Возвращает [DeclarationModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<DeclarationModel> getSingleDeclaration(String id);
}

class DeclarationRemoteDataSource implements IDeclarationRemoteDataSource {
  final IDeclarationLocalDataSource localDatasource;
  final Dio dio;

  DeclarationRemoteDataSource(this.localDatasource, this.dio);

  @override
  Future<List<DeclarationModel>> fetchDeclarations(int page) async {
    // final String baseUrl =
    //     '${AppConfig.apiUri}/cportal/hs/api/news/1.1/?page=$page';

    try {
      // final response = await dio.get<String>(baseUrl);

      // log('NewsRemoteDataSource ${response.data}');
      // final declarations = DeclarationModel.fromJson(
      //   json.decode(response.data!) as Map<String, dynamic>,
      // );

      // await localDatasource.declarationsToCache(news);

      throw UnimplementedError();
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<DeclarationModel> getSingleDeclaration(String id) {
    throw UnimplementedError();
  }
}
