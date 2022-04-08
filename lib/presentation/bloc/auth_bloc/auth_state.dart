import 'package:cportal_flutter/presentation/bloc/submission_status.dart';

class AuthState {
  final String connectingCode;

  final SubmissionStatus submissionStatus;

  AuthState({
    this.connectingCode = '',
    this.submissionStatus = const InitialStatus(),
  });

  AuthState copyWith({
    String? connectingCode,
    SubmissionStatus? submissionStatus,
  }) {
    return AuthState(
      connectingCode: connectingCode ?? this.connectingCode,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  String toString() {
    return '$submissionStatus';
  }
}
