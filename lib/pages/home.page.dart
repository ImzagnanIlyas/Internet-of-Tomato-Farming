import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/pages/QA/nodePower.dart';
import 'package:internet_of_tomato_farming/pages/QA/pin.page.dart';
import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/pages/tabs/plantStatus.page.dart';
import 'package:internet_of_tomato_farming/pages/tabs/sensors.page.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class HomePage extends StatefulWidget {
  bool didNotificationLaunchApp;
  HomePage({Key? key, this.didNotificationLaunchApp=false}): super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _currentSelection = 0;
  late Timer timer;



  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_){
      if(widget.didNotificationLaunchApp) onNotificationLaunchApp();
    });
    // launchCallbackDispatchers();
  }

  void launchCallbackDispatchers(){
    SensorsServices sensorsService = SensorsServices();
    sensorsService.dht11DataCallbackDispatcher();
    sensorsService.moistureDataCallbackDispatcher();
    sensorsService.phDataCallbackDispatcher();
    sensorsService.npkDataCallbackDispatcher();
    sensorsService.diseaseDataCallbackDispatcher();
  }


  @override
  Widget build(BuildContext context) {
    Map<int, Widget> _children = {
      0: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 5,
        ),
        Text(
          'Sensors Data',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.sensors,
          size: 20,
        ),
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
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.ac_unit,
          size: 20,
        ),
        SizedBox(
          width: 5,
        )
      ]),
    };

    int unreadNotifications = NotificationService().getUnreadNotificationNumber();

    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.lightGreen,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => PinPage()),);
                  },
                  child: Icon(
                    Icons.code,
                    size: 25.0,
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => NodePower()),);
                  },
                  child: Icon(
                    Icons.power_settings_new,
                    size: 25.0,
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                  label: (unreadNotifications > 0) ? Text(unreadNotifications.toString()) : Container(),
                  icon: Icon(Icons.notifications_active, size: 25,
                    color: (unreadNotifications > 0) ? Colors.white : Colors.lightGreen
                  ),
                  backgroundColor: (unreadNotifications > 0) ? Colors.redAccent : Colors.white,
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  }),
            ),
          ]),
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
        GestureDetector(
          onTap: () {
            setState(() {});
            launchCallbackDispatchers();
          },
          child: (_currentSelection == 0) ? SensorTab() : PlantStatusTab(),
        ),
      ]),
    );
  }

  void onNotificationLaunchApp(){
    Navigator.pushNamed(context, '/notifications');
  }
}
