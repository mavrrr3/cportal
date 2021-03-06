import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class IDeclarationRepository {
  Future<Either<Failure, List<DeclarationEntity>>> fetchDeclarations(int page);
  Future<Either<Failure, DeclarationEntity>> getSingleDeclaration(String id);
  Future<Either<Failure, List<DeclarationEntity>>> searchDeclarations(
    String query,
  );
}
