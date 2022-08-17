import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_model.dart';

abstract class IDeclarationsRemoteDataSource {
  Future<List<DeclarationModel>> fetchDeclarations(int page);
  Future<DeclarationInfoModel> getSingleDeclaration(String id);
  Future<List<DeclarationModel>> searchDeclaration(String text);
  // Future<void> cancelDeclaration(int id);.
}
