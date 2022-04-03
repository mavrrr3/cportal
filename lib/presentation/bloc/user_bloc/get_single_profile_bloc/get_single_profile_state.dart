import 'package:cportal_flutter/domain/entities/profile_entity.dart';
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

  @override
  List<Object?> get props => [profile];
}

class GetSingleProfileLoadingError extends GetSingleProfileState {
  final String message;

  const GetSingleProfileLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
