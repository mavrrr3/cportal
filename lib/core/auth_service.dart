import 'package:cportal_flutter/feature/data/repositories/auth_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final IAuthRepository _authRepository;

  AuthenticationStatus _authStatus = AuthenticationStatus.unknown;

  AuthService(this._authRepository) {
    onAppStart();
  }

  AuthenticationStatus get authStatus => _authStatus;

  Future<void> onAppStart() async {
    _authRepository.status.listen((event) {
      _authStatus = event;
      notifyListeners();
    });
  }
}
