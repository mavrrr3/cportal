import 'package:equatable/equatable.dart';

abstract class GetSingleUserEvent extends Equatable {
  const GetSingleUserEvent();

  @override
  List<Object> get props => [];
}

class GetSingleUserEventImpl extends GetSingleUserEvent {
  final String id;

  const GetSingleUserEventImpl(this.id);
}
