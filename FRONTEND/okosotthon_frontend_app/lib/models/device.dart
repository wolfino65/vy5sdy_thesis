import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

@JsonSerializable()
class Device {
  @JsonKey(name: "_id")
  final id;
  final owner;
  final location;
  @JsonKey(name: "device_name")
  final deviceName;
  final additionalInfo; //JSON object

  Device({
    required this.id,
    required this.owner,
    required this.location,
    required this.deviceName,
    required this.additionalInfo,
  });

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
        additionalInfo: ${additionalInfo?.toString() ?? 'null'}
      }''';
  }
}
