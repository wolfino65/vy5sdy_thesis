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
    final List<dynamic> jsonList = json.decode(resp.body);
    return jsonList.map((jsonItem) {
      try {
        return Device.fromJson(jsonItem);
      } catch (e) {
        print('Error parsing device: $e\nJSON: $jsonItem');
        return Device.empty();
      }
    }).toList();
  }
}