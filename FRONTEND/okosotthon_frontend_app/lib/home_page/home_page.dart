import 'dart:async';
import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/add_device_page/add_device.dart';
import 'package:okosotthon_frontend_app/device_page/device_page.dart';
import 'package:okosotthon_frontend_app/home_page/get_devices_to_list.dart';
import 'package:okosotthon_frontend_app/models/device.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key});
  @override
  State<StatefulWidget> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List<Device> _listOfDevices = [];

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
        actions: [
          
        ],
      ),
      body: Container(child: buildDeviceList(context)),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDevice()),
              ).then((_) => {loadData()}),
            },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> loadData() async {
    if (this.mounted) {
      final l = await DeviceFetcher.getDevicesByOwner();
      setState(() {
        this._listOfDevices = l as List<Device>;
      });
    }
  }

  Widget buildDeviceList(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: _listOfDevices.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_listOfDevices[index].deviceName),
          onTap: () {
            navigateToDevicePage(context, _listOfDevices[index]);
          },
          tileColor: Colors.green,
        );
      },
    );
  }

  void navigateToDevicePage(BuildContext context, Device dev) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DevicePage(dev)),
    ).then((_) => {loadData()});
  }
}
