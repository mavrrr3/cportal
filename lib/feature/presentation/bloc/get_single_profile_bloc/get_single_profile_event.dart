import 'package:equatable/equatable.dart';

abstract class GetSingleProfileEvent extends Equatable {
  const GetSingleProfileEvent();

  @override
  List<Object> get props => [];
}

class GetSingleProfileEventImpl extends GetSingleProfileEvent {
  final String id;
  final bool isMyProfile;

  const GetSingleProfileEventImpl(
    this.id, {
    this.isMyProfile = false,
  });

  @override
  List<Object> get props => [id];
}
