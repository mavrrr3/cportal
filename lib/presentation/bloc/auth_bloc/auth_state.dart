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

class AuthUser extends AuthState {
  final UserEntity user;

  const AuthUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class Authenticated extends AuthState {
  final bool isAuth;
  const Authenticated(this.isAuth);

  @override
  List<Object?> get props => [isAuth];
}

class ErrorAuthState extends AuthState {
  final String error;

  const ErrorAuthState({required this.error});

  @override
  List<Object?> get props => [error];
}
