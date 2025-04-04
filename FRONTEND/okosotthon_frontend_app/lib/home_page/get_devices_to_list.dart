import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceFetcher {
  static Future<List> getDevicesByOwner  () async{
    final prefs = await SharedPreferences.getInstance(); 
    final resp = await http.get(Uri.parse("http://192.168.1.82:4500/device/getDeviceByOwner"),
      headers: <String,String>{
        "owner": prefs.getString('id')as String
      }
    );

    if(resp.statusCode!=200){
      throw Exception("Something went wrong.");
    }
    List<Device> devices=<Device>[];
    for (var jsonItem in json.decode(resp.body)) {
      devices.add(Device.fromJson(jsonItem));
    }
    return devices;
  }
}