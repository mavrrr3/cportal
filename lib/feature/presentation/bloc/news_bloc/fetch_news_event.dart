import 'package:equatable/equatable.dart';

abstract class FetchNewsEvent extends Equatable {
  const FetchNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsEventImpl extends FetchNewsEvent {
  const FetchNewsEventImpl();
}
