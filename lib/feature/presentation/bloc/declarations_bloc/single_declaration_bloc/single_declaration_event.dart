import 'package:equatable/equatable.dart';

abstract class SingleDeclarationEvent extends Equatable {
  const SingleDeclarationEvent();

  @override
  List<Object> get props => [];
}

class GetSingleDeclarationEvent extends SingleDeclarationEvent {
  final String id;
  final bool isTask;

  const GetSingleDeclarationEvent({required this.id, required this.isTask});

  @override
  List<Object> get props => [id];
}
