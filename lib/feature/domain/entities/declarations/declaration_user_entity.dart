import 'package:cportal_flutter/common/util/random_color_service.dart';
import 'package:flutter/material.dart';

class DeclarationUserEntity {
  final String id;
  final String fullName;
  final String position;
  final String image;
  final Color color = RandomColorService.color;

  DeclarationUserEntity({
    required this.id,
    required this.fullName,
    required this.position,
    required this.image,
  });
}
