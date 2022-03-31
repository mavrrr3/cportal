import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';

abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object?> get props => [];
}

class GetSingleUserEmptyState extends GetSingleUserState {}

class GetSingleUserLoadingState extends GetSingleUserState {}

class GetSingleUserLoadedState extends GetSingleUserState {
  final UserEntity user;
  const GetSingleUserLoadedState({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetSingleUserLoadingError extends GetSingleUserState {
  final String message;

  const GetSingleUserLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
