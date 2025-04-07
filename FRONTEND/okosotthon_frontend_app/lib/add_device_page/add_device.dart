import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:http/http.dart' as http;

class AddDevice extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice>{
  final String deviceSSID="test";
  List<WiFiAccessPoint> accessPoints=[];

  @override
  void initState() {
    super.initState();
    _getAllAvailableAPs();
  }
  late String dropdownValue=accessPoints.first.ssid;

  @override
  Widget build(BuildContext context) {
    TextEditingController pwCont=TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title:Text("Add device"),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text("The device needs to connect to a network.\nPlease connect to the WiFi with the name "+deviceSSID+" then please select the network you want the device to connect to."),
          SizedBox(height: 10,),
          DropdownButton(items: accessPoints.map<DropdownMenuItem<String>>((WiFiAccessPoint ap) {
            return DropdownMenuItem<String>(value: ap.ssid, child: Text(ap.ssid));
          }).toList(),
          value: dropdownValue,
           onChanged: (value){
            setState(() {
              this.dropdownValue = value as String;
            });
           },
           icon: const Icon(Icons.arrow_downward),
           ),
          InputFields.buildPasswdField(pwCont, "", "Wifi passowrd",MediaQuery.sizeOf(context).width*0.8),
          InputFields.buildCustomizedButton("Configure", Colors.blue.shade400, Colors.white, ()=>{
            _configure(dropdownValue, pwCont.text)
          })
        ],
      )
    );
  }

  Future<void> _getAllAvailableAPs() async{
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch(can) {
    case CanStartScan.yes:
      await WiFiScan.instance.startScan();
      List<WiFiAccessPoint> apsWithDuplicates=await WiFiScan.instance.getScannedResults();
      List<String> apNames = [];
      List<WiFiAccessPoint> aps=[];
      for (WiFiAccessPoint ap in apsWithDuplicates){
        if(!apNames.contains(ap.ssid) && ap.ssid !="" ){
          apNames.add(ap.ssid);
          aps.add(ap);
        }
      }
      setState(() {
        accessPoints=aps;
      });
      break;
    default:
      throw Exception("Scan not available");
    }
  }


  void _configure(String ssid, String pw) async{
      final prefs= await SharedPreferences.getInstance();
      await http.post(Uri.parse("http://192.168.0.5:60/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String,String>{
          "ssid":ssid,
          "password":pw,
          "owner": prefs.getString("id") as String
        }
      ),
      );
  }
}