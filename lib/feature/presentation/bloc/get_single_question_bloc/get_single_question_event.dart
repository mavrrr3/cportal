import 'package:equatable/equatable.dart';

abstract class GetSingleQuestionEvent extends Equatable {
  const GetSingleQuestionEvent();

  @override
  List<Object> get props => [];
}

class GetSingleQuestionEventImpl extends GetSingleQuestionEvent {
  final String id;

  const GetSingleQuestionEventImpl(this.id);

  @override
  List<Object> get props => [id];
}
