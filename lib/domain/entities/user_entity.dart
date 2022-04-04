import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.userName,
    required this.profileId,
    required this.lastLogin,
    required this.blocked,
    required this.dateCreated,
    required this.userCreated,
    required this.dateUpdated,
    required this.userUpdated,
    required this.userType,
  });

  final String id;
  final String userName;
  final String profileId;
  final DateTime lastLogin;
  final bool blocked;
  final DateTime dateCreated;
  final String userCreated;
  final DateTime? dateUpdated;
  final String userUpdated;
  final UserTypeEntity userType;

  @override
  List<Object?> get props => [
        id,
        userName,
        profileId,
        lastLogin,
        blocked,
        dateCreated,
        userCreated,
        dateUpdated,
        userUpdated,
        userType,
      ];
}

class UserTypeEntity {
  UserTypeEntity({
    required this.id,
    required this.code,
    required this.description,
  });

  final String id;
  final String code;
  final String description;
}
