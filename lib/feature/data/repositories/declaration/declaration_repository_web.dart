import 'package:cportal_flutter/feature/domain/entities/declaration_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_declaration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class DeclarationRepositoryWeb extends IDeclarationRepository {
  @override
  Future<Either<Failure, List<DeclarationEntity>>> fetchDeclarations(int page) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DeclarationEntity>> getSingleDeclaration(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DeclarationEntity>>> searchDeclarations(
    String query,
  ) {
    throw UnimplementedError();
  }
}
