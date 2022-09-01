import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_card_model.dart';

abstract class IDeclarationsRemoteDataSource {
  Future<List<DeclarationCardModel>> fetchDeclarations(int page);
  Future<DeclarationInfoModel> getSingleDeclaration(String id);
  Future<List<DeclarationCardModel>> searchDeclaration(String text);
}
