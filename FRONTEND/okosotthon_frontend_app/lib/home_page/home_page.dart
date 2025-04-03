import 'dart:async';
import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/home_page/get_devices_to_list.dart';
import 'package:okosotthon_frontend_app/models/device.dart';


class DeviceList extends StatefulWidget {
  const DeviceList({super.key});
  @override
  State<StatefulWidget> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List<Device> _listOfDevices =[];

  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your devices'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container( child:   buildDeviceList(context) )
    );
  }
  Future<void> loadData() async{
      if (this.mounted) {
      Timer(Duration(milliseconds: 3000), () async {
        final l = await DeviceFetcher.getDevicesByOwner();
        print(l.length);
        setState(() {
          this._listOfDevices = l as List<Device>;
        });
      });
    }
  }

  Widget buildDeviceList(BuildContext context)  {
    
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _listOfDevices.length,
      itemBuilder: (BuildContext context, int index) {
        
        return ListTile(
          title: Text(_listOfDevices[index].deviceName),
          onTap: () {
            print('tapped');
          },
          tileColor: Colors.green,
        );
      },
    );
  }
}
