enum StepStatus { done, inProcess, declined }

StepStatus getDeclarationStepStatus({required String status}) {
  switch (status) {
    case 'Сделано':
      return StepStatus.done;
    case 'В процессе':
      return StepStatus.inProcess;
    default:
      return StepStatus.declined;
  }
}
