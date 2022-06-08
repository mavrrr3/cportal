import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
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
      try {
        final localContacts = await localDataSource.fetchContactsFromCache();

        return Right(localContacts);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
