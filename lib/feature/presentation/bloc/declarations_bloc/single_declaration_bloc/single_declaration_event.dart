import 'package:equatable/equatable.dart';

abstract class SingleDeclarationEvent extends Equatable {
  const SingleDeclarationEvent();

  @override
  List<Object> get props => [];
}

class GetSingleDeclarationEvent extends SingleDeclarationEvent {
  final String id;

  const GetSingleDeclarationEvent(this.id);

  @override
  List<Object> get props => [id];
}
