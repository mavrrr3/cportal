import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_card_model.dart';

abstract class IDeclarationsLocalDataSource {
  Future<List<DeclarationCardModel>> fetchDeclarationsFromCache(int page);
  Future<void> declarationsToCache(
    List<DeclarationCardModel> declarations,
    int page,
  );
}
