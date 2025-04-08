import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:okosotthon_frontend_app/models/ui_element.dart';

part 'ui.g.dart';

@JsonSerializable()
class Ui {
  @JsonKey(name: "fields")
  List<UiElement> elements;

  Ui({
    required this.elements,
  });

  factory Ui.fromJson(Map<String, dynamic> json) => _$UiFromJson(json);

  Map<String, dynamic> toJson() => _$UiToJson(this);

}