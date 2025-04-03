// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: json['_id'],
  owner: json['owner'],
  location: json['location'],
  deviceName: json['device_name'],
  additionalInfo: json['additionalInfo'],
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  '_id': instance.id,
  'owner': instance.owner,
  'location': instance.location,
  'device_name': instance.deviceName,
  'additionalInfo': instance.additionalInfo,
};
