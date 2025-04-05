// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: json['_id'] as String,
  owner: json['owner'] as String,
  location: json['location'] as String,
  deviceName: json['device_name'] as String,
  aditionalInfo: AditionalinfoDevice.fromJson(
    json['aditionalInfo'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  '_id': instance.id,
  'owner': instance.owner,
  'location': instance.location,
  'device_name': instance.deviceName,
  'aditionalInfo': instance.aditionalInfo,
};
