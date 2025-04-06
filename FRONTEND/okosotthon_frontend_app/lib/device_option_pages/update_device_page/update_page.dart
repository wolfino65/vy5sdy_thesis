import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class UpdateDevice extends StatefulWidget{
  Device dev=Device.empty();

  UpdateDevice(Device dev){
    this.dev=dev;
  }

  @override
  State<StatefulWidget> createState() => _UpdateDeviceState(dev);
}

class _UpdateDeviceState extends State<UpdateDevice>{
  Device dev = Device.empty();

  _UpdateDeviceState(Device dev){
    this.dev=dev;
  }

  TextEditingController name = TextEditingController();
  TextEditingController loc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text=dev.deviceName;
    loc.text=dev.location;
    return Scaffold(
        appBar: AppBar(
          title: Text("Update device details"),
          backgroundColor: Colors.deepOrangeAccent.shade100,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 50),
              InputFields.buildSimpleTextField(name, TextInputType.text,"Device name","",MediaQuery.sizeOf(context).width*0.8),
              SizedBox(height: 100),
              InputFields.buildSimpleTextField(loc, TextInputType.text,"Device location","",MediaQuery.sizeOf(context).width*0.8),
              SizedBox(height: 50),
              InputFields.buildCustomizedButton("Update", Colors.lightGreen.shade600, Colors.white, ()=>_handleUpdate())
            ],
          ),
        )
    );
  }

  void _handleUpdate(){
    _handleUpdateAsync(name.text, loc.text);

    Navigator.pop(context,[name.text,loc.text]);
  }

  Future<void> _handleUpdateAsync(String name, String loc) async{
    final resp= await http.put(Uri.parse("http://192.168.1.82:4500/device/updateDevice"),
    headers:  <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode( <String,dynamic>{
        "dev_id":dev.id,
        "newInfo":{
          "device_name":name,
          "location":loc
        }
      }
      )
    );
  }


}