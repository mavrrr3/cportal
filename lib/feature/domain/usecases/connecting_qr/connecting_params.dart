import 'package:equatable/equatable.dart';

class ConnectingParams extends Equatable {
  final String connectingCode;

  const ConnectingParams({
    required this.connectingCode,
  });
  @override
  List<Object?> get props => [connectingCode];
}
