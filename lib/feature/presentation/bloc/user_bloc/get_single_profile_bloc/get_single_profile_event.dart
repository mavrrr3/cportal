import 'package:equatable/equatable.dart';

abstract class GetSingleProfileEvent extends Equatable {
  const GetSingleProfileEvent();

  @override
  List<Object> get props => [];
}

class GetSingleProfileEventImpl extends GetSingleProfileEvent {
  final String id;

  const GetSingleProfileEventImpl(this.id);

  @override
  List<Object> get props => [id];
}
