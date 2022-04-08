part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authinticated extends AuthState {}

class UnAuthinticated extends AuthState {}
