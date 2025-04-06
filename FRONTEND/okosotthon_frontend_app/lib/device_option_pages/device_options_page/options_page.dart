import 'package:flutter/material.dart';
import 'package:okosotthon_frontend_app/shared/InputFields.dart';
import 'package:okosotthon_frontend_app/models/device.dart';
import 'package:okosotthon_frontend_app/models/module.dart';
import 'package:okosotthon_frontend_app/shared/Shared_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceOptions extends StatefulWidget{
  Device dev = Device.empty();

  DeviceOptions(this.dev);

  @override
  State<StatefulWidget> createState() => _DeviceOptionsState(dev);
}

class _DeviceOptionsState extends State<DeviceOptions> {
  var prefs;

  Device dev = Device.empty();
  @override
  void initState() {
    super.initState();
    _getPrefs();
  }
  _DeviceOptionsState(this.dev);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Options"),
          backgroundColor: Colors.amber.shade300,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
          children: [
            SizedBox(height: 50,),
            InputFields.buildCustomizedButton("Remove module", Colors.lightBlue.shade200, Colors.black54, ()=>_removeModule()),
            SizedBox(height: 50,),
            InputFields.buildCustomizedButton("Reset network", Colors.lightBlue.shade200, Colors.black54, ()=>_networkReset()),
            SizedBox(height: 50,),
            InputFields.buildCustomizedButton("Reset modules", Colors.lightBlue.shade200, Colors.black54, ()=>_moduleReset()),
          ],
        )),
    );
  }


  void _removeModule() async{
    await Shared.scheduleTask(dev.id, Module.empty(), "remove", (prefs as SharedPreferences).getString('id') as String, {});
    Shared.showCustomDialog(context, "Instructions", "Please remove the module.");
  }

  void _networkReset(){
    String content="This will disconnect the device from the network.\nYou can reconnect the device later and it still will be linked to your account.\nDo you want to continue?";
    Shared.buildChoiceDialog(context, "Warning", content, ()=>{_handleNetworkResetYes()}, (){Navigator.pop(context);});
  }

  void _moduleReset(){
    String content="This will disconnect all modules from the device.\nDo you want to continue?";
    Shared.buildChoiceDialog(context, "Warning", content, ()=>{_handleModuleResetYes()}, (){Navigator.pop(context);});
    
  }

  void _getPrefs() async{
    prefs = await SharedPreferences.getInstance();
  }

  void _handleNetworkResetYes(){
    Shared.scheduleTask(dev.id, Module.empty(), "network_reset",(prefs as SharedPreferences).getString('id') as String , {});
    Navigator.pop(context);
  }
  void _handleModuleResetYes(){
    Shared.scheduleTask(dev.id, Module.empty(), "module_reset", (prefs as SharedPreferences).getString('id') as String, {});
    Navigator.pop(context);
  }
}