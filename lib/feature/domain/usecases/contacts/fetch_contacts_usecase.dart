import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchContactsUseCase extends IUseCase<ContactsEntity, FetchContactsParams> {
  final IContactsRepository contactsRepository;

  FetchContactsUseCase(this.contactsRepository);

 @override
  Future<Either<Failure, ContactsEntity>> call(FetchContactsParams params) =>
      contactsRepository.fetchContacts(params.page);
  
}


class FetchContactsParams extends Equatable {
  final int page;

  const FetchContactsParams({required this.page});
  @override
  List<Object?> get props => [page];
}
