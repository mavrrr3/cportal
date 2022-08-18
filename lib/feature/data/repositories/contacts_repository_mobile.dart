import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:dartz/dartz.dart';

class ContactsRepositoryMobile implements IContactsRepository {
  final IContactsRemoteDataSource remoteDataSource;
  final IContactsLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  ContactsRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, ContactsModel>> fetchContacts(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteContacts = await remoteDataSource.fetchContacts(page);

        return Right(remoteContacts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      if (page == 1) {
        try {
          final localContacts = await localDataSource.fetchContactsFromCache();

          return Right(localContacts);
        } on CacheFailure {
          return Left(CacheFailure());
        }
      } else {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> searchContacts(
    String query,
    List<FilterEntity> filters,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteContacts =
            await remoteDataSource.fetchContactsBySearch(query, filters);

        return Right(remoteContacts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localContacts = await localDataSource.fetchContactsFromCache();

        final List<ProfileEntity> contacts = [];

        for (final element in localContacts.contacts) {
          if (element.fullName.contains(query)) {
            contacts.add(element);
          }
        }

        return Right(contacts);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
