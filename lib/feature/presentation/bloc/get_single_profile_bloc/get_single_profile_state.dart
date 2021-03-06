import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetSingleProfileState extends Equatable {
  const GetSingleProfileState();

  @override
  List<Object?> get props => [];
}

class GetSingleProfileEmptyState extends GetSingleProfileState {}

class GetSingleProfileLoadingState extends GetSingleProfileState {}

class GetSingleProfileLoadedState extends GetSingleProfileState {
  final ProfileEntity profile;
  const GetSingleProfileLoadedState({required this.profile});

  String get getPhone => profile.contactInfo
      .firstWhere((element) => element.type == 'Личный номер телефона')
      .contact;

  String get getEmail => profile.contactInfo
      .firstWhere((element) => element.type == 'Эл. почта')
      .contact;

  @override
  List<Object?> get props => [profile];
}

class GetSingleProfileLoadingError extends GetSingleProfileState {
  final String message;

  const GetSingleProfileLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
