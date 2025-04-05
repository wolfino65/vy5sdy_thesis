import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class DeviceOptions extends StatefulWidget{
  Device dev = Device.empty();

  DeviceOptions(this.dev);

  @override
  State<StatefulWidget> createState() => _DeviceOptionsState(dev);
}

class _DeviceOptionsState extends State<DeviceOptions>{
  Device dev = Device.empty();

  _DeviceOptionsState(this.dev);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}