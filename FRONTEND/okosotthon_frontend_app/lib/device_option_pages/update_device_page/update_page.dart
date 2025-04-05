import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
    );
  }
}