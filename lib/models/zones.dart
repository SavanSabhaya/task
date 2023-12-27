import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(genericArgumentFactories: true)
class Zones {
  @JsonKey(name:"title")
  final String title;
  @JsonKey(name:"sub_title")
  final String subTitle;
  @JsonKey(name:"image")
  final String image;
  bool isCheck = false;

  Zones({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}