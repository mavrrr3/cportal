abstract class SubmissionStatus {
  const SubmissionStatus();
}

class InitialStatus extends SubmissionStatus {
  const InitialStatus();
}

class Submitting extends SubmissionStatus {}

class SubmissionSuccess extends SubmissionStatus {}

class SubmissionFailed extends SubmissionStatus {
  final String errorMessage;
  const SubmissionFailed(this.errorMessage);
}
