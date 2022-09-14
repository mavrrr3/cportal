import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(createToJson: false)
class Location {
  final String country;
  final String city;

  Location(this.country, this.city);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  String get fullLocation => '$city, $country';
}
