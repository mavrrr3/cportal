import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:dartz/dartz.dart';

class FetchContactsUseCase {
  final IContactsRepository contactsRepository;

  FetchContactsUseCase(this.contactsRepository);

  Future<Either<Failure, ContactsEntity>> call() async =>
      contactsRepository.fetchContacts();
}
