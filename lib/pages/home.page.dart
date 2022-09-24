import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/pages/tabs/plantStatus.page.dart';
import 'package:internet_of_tomato_farming/pages/tabs/sensors.page.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../shared/toasts.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentSelection = 0;

  List<Dht11Model> dht11Data = [];


  @override
  Widget build(BuildContext context) {
    Map<int, Widget> _children = {
      0: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 5,
        ),
        Text(
          'Sensors Data',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(Icons.sensors, size: 15,),
        SizedBox(
          width: 5,
        )
      ]),
      1: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 5,
        ),
        Text(
          'Plant Status',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(Icons.ac_unit, size: 15,),
        SizedBox(
          width: 5,
        )
      ]),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView(children: [
        MaterialSegmentedControl(
          children: _children,
          selectionIndex: _currentSelection,
          borderColor: Colors.lightGreen,
          selectedColor: Colors.lightGreen,
          unselectedColor: Colors.white,
          borderRadius: 6.0,
          verticalOffset: 15.0,
          horizontalPadding: EdgeInsets.all(10),
          onSegmentChosen: (index) {
            setState(() {
              _currentSelection = index as int;
            });
          },
        ),
        if (_currentSelection == 0) SensorTab(),
        if (_currentSelection == 1) PlantStatusTab(),

      ]),
    );
  }
}
