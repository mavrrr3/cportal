import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_user_model.g.dart';

@JsonSerializable(createToJson: false)
class ResponseUserModel {
  final UserModel response;

  ResponseUserModel(this.response);

  factory ResponseUserModel.fromJson(Map<String, dynamic> json) => _$ResponseUserModelFromJson(json);
}
