import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String type;
  final String contact;

  const ContactEntity({required this.type, required this.contact});

  @override
  List<Object?> get props => [type, contact];
}
