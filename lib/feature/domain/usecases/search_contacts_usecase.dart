import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchContactsUseCase
    extends IUseCase<List<ProfileEntity>, SearchContactsParams> {
  final IContactsRepository contactsRepository;

  SearchContactsUseCase(this.contactsRepository);

  @override
  Future<Either<Failure, List<ProfileEntity>>> call(
    SearchContactsParams params,
  ) =>
      contactsRepository.searchContacts(params.query);
}

class SearchContactsParams extends Equatable {
  final String query;

  const SearchContactsParams({required this.query});
  @override
  List<Object?> get props => [query];
}
