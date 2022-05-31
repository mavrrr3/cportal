import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:dartz/dartz.dart';

class ContactsRepositoryWeb implements IContactsRepository {
  final IContactsRemoteDataSource remoteDataSource;

  ContactsRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, ContactsModel>> fetchContacts() async {
    try {
      final remoteContacts = await remoteDataSource.fetchContacts();

      return Right(remoteContacts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}