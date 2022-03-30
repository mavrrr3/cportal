import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String position;
  final String image;
  final String department;
  final String email;
  final String internalPhone;
  final String externalPhone;

  const UserEntity({
    required this.id,
    required this.username,
    required this.position,
    required this.image,
    required this.department,
    required this.email,
    required this.internalPhone,
    required this.externalPhone,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        position,
        image,
        department,
        email,
        internalPhone,
        externalPhone,
      ];
}
