import 'package:json_annotation/json_annotation.dart';
part 'module.g.dart';

@JsonSerializable()
class Module {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "front_id")
  String frontID;
  String name;

  Module({
    required this.id,
    required this.frontID,
    required this.name
  });
  
  Module.empty({
    this.id="",
    this.frontID="",
    this.name="Unused"
  });
  
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
  
}
