import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DeclarationUserEntity extends Equatable {
  final String id;
  final String fullName;
  final String position;
  final String image;
  final Color color = ColorService.randomColor;

  DeclarationUserEntity({
    required this.id,
    required this.fullName,
    required this.position,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        position,
        image,
        color,
      ];
}
