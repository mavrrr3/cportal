import 'package:equatable/equatable.dart';

abstract class GetSingleNewsEvent extends Equatable {
  const GetSingleNewsEvent();

  @override
  List<Object> get props => [];
}

class GetSingleNewsEventImpl extends GetSingleNewsEvent {
  final String id;

  const GetSingleNewsEventImpl(this.id);

  @override
  List<Object> get props => [id];
}
