import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object?> get props => [];
}

class InProgress extends AuthState {
  const InProgress();
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class ErrorAuthState extends AuthState {
  final String error;

  const ErrorAuthState({required this.error});

  @override
  List<Object?> get props => [error];
}
