import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class IDeclarationRepository {
  Future<Either<Failure, List<DeclarationCardEntity>>> fetchDeclarations(
    int page,
  );
  Future<Either<Failure, DeclarationInfoEntity>> getSingleDeclaration(
    String id,
  );
  Future<Either<Failure, List<DeclarationCardEntity>>> searchDeclarations(
    String query,
  );
}
