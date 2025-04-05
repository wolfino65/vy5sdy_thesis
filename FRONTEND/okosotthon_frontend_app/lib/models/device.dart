import 'package:json_annotation/json_annotation.dart';
import 'package:okosotthon_frontend_app/models/aditionalInfo_device.dart';
part 'device.g.dart';

@JsonSerializable()
class Device {
  @JsonKey(name: "_id")
  String id;
  String owner;
  String location;
  @JsonKey(name: "device_name")
  String deviceName;
  final AditionalinfoDevice aditionalInfo; 

  Device({
    required this.id,
    required this.owner,
    required this.location,
    required this.deviceName,
    required this.aditionalInfo,
  });
  Device.empty()
    : id = '',
      owner = '',
      location = '',
      deviceName = '',
      aditionalInfo = AditionalinfoDevice.empty();

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  @override
  String toString() {
    return '''
      Device {
        id: $id,
        owner: $owner,
        location: $location,
        deviceName: $deviceName,
        additionalInfo: ${aditionalInfo.toString()}
      }''';
  }
}
