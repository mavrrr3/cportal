import 'dart:developer';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:dartz/dartz.dart';

class ContactsRepositoryWeb implements IContactsRepository {
  final IContactsRemoteDataSource remoteDataSource;

  ContactsRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, ContactsModel>> fetchContacts(int page) async {
    try {
      final remoteContacts = await remoteDataSource.fetchContacts(page);
      log('ContactsRepositoryWeb $remoteContacts');

      return Right(remoteContacts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> searchContacts(
    String query,
  ) async {
    try {
      final remoteContacts =
          await remoteDataSource.fetchContactsBySearch(query);

      return Right(remoteContacts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
