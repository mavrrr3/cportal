import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IContactsRepository {
  Future<Either<Failure, ContactsEntity>> fetchContacts();
}