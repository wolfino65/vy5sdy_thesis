// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aditionalInfo_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AditionalinfoDevice _$AditionalinfoDeviceFromJson(Map<String, dynamic> json) =>
    AditionalinfoDevice(
      connected:
          (json['connected'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AditionalinfoDeviceToJson(
  AditionalinfoDevice instance,
) => <String, dynamic>{'connected': instance.connected};
