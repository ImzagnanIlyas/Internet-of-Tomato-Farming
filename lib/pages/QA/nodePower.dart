import 'package:flutter/material.dart';

class NodePower extends StatefulWidget {
  const NodePower({Key? key}) : super(key: key);

  @override
  State<NodePower> createState() => _NodePowerState();
}

class _NodePowerState extends State<NodePower> {
  bool isSwitched = false;
  var textValue = 'NODE is OFF';

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'NODE is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'NODE is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Node Power"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[ Transform.scale(
                scale: 5,
                child: Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.lightGreenAccent,
                  inactiveThumbColor: Colors.redAccent,
                  inactiveTrackColor: Colors.orange,
                )
            ),
              SizedBox(height: 40),
              Text('$textValue', style: TextStyle(fontSize: 25),)
            ]),
      )
    );
  }
}
