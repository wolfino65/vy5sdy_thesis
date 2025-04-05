import 'package:json_annotation/json_annotation.dart';
part 'aditionalInfo_device.g.dart';

@JsonSerializable()
class AditionalinfoDevice {
  //@JsonKey(name: 'connected:')
  List<String> connected;

  AditionalinfoDevice({required this.connected});

  AditionalinfoDevice.empty() : connected = [];

  factory AditionalinfoDevice.fromJson(Map<String, dynamic> json) => _$AditionalinfoDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$AditionalinfoDeviceToJson(this);

}