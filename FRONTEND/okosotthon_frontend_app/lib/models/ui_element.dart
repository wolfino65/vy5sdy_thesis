import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ui_element.g.dart';

@JsonSerializable()
class UiElement {
  String name;
  String type;
  @JsonKey(name: "name_in_response")
  String respName;

  UiElement({
    required this.name,
    required this.type,
    required this.respName,
  });

  factory UiElement.fromJson(Map<String, dynamic> json) => _$UiElementFromJson(json);

  Map<String, dynamic> toJson() => _$UiElementToJson(this);

}