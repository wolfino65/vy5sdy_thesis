// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ui _$UiFromJson(Map<String, dynamic> json) => Ui(
  elements:
      (json['fields'] as List<dynamic>)
          .map((e) => UiElement.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$UiToJson(Ui instance) => <String, dynamic>{
  'fields': instance.elements,
};
