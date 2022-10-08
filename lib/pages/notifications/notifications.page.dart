import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/moistureNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/npkDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/phNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/temp&HumNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/extensions.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late var prefs;

  Future<dynamic> initPrefs() async{
    return SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.lightGreen,
        // actions: [
        //   IconButton(onPressed: clearData, icon: Icon(Icons.delete)),
        //   IconButton(onPressed: saveDummyData, icon: Icon(Icons.save_alt)),
        // ],
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: FutureBuilder(
           future: initPrefs(),
           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
             if(snapshot.hasData){
               prefs = snapshot.data;
               return ListView(children: _buildNotifsWidgets());
             }else{
               return const Center();
             }
           }
         ),
        ),
      ),
    );
  }

  List<Widget> _buildNotifsWidgets(){
    List<NotificationModel> notifications = getNotifications();
    // String json = prefs.getString('notifications') ?? '[]';
    // List<dynamic> jsonList = jsonDecode(json);
    // for(dynamic e in jsonList){
    //   notifications.add(NotificationModel.fromJson(e));
    // }
    notifications.sort((a, b) => b.time.compareTo(a.time));

    List<Widget> widgets = [];
    for(NotificationModel e in notifications){
      Color backgroundColor = (e.seen) ? Colors.grey[300]! : Colors.lightGreen;
      Color foregroundColor = (e.seen) ? Colors.black : Colors.white;
      IconData icon = (e.seen) ? Icons.notifications_none : Icons.notifications_active;
      Color iconColor = (e.seen) ? Colors.black45 : Colors.white;
      Color timeColor = (e.seen) ? Colors.black45 : Colors.white70;
      String time = e.time.toNotificationFormat();
      Widget nextUI = const Scaffold();
      if(e.type == SensorType.dht11){
        nextUI = TempAndHumNotifDisplay(e.status, e.value['temperature'], e.value['humidity']);
      }else if(e.type == SensorType.pH){
        nextUI = PhNotifDisplay(e.value, e.status);
      }else if(e.type == SensorType.moisture){
        nextUI = MoistureNotifDisplay(e.status, e.value);
      }else if(e.type == SensorType.npk){
        nextUI = NpkNotifDisplay(
            e.status['nitrogenCondition'],
            e.status['phosphorusCondition'],
            e.status['potassiumCondition'],
            e.value['nitrogenValue'], e.value['phosphorusValue'], e.value['potassiumValue'],
            e.status['plantGrowthStage']
        );
      }
      widgets.add(
          ElevatedButton(
              onPressed: (){
                markAsSeen(e.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => nextUI
                  ),
                );
                setState((){});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(time, style: TextStyle(color: timeColor)),
                      SizedBox(width: 5),
                      Icon(icon,color: iconColor),
                    ],
                  ),
                  Text(e.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(e.body, style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(backgroundColor),
                foregroundColor: MaterialStateProperty.all(foregroundColor),
                alignment: Alignment.topRight,
                padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                elevation: MaterialStateProperty.all(10),
                shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )
                )
              )
          )
      );
      widgets.add(Divider());
    }

    if(widgets.isEmpty){
      widgets.add(
        Center(
          child: Text("Empty"),
        )
      );
    }

    return widgets;
  }

  void saveDummyData(){
    int id = prefs.getInt('notificationID');
    if(id == null){
      prefs.setInt('notificationID', 0);
      id = 0;
    }
    Map<String, dynamic> dht1Value = {
      'temperature': 11,
      'humidity': 80
    };
    Map<String, dynamic> npkValue = {
      'nitrogenValue': 20.2,
      'phosphorusValue': 30.1,
      'potassiumValue': 28.3
    };
    Map<String, dynamic> npkStatus = {
      'nitrogenCondition': ConditionNpk.Low,
      'phosphorusCondition': ConditionNpk.Good,
      'potassiumCondition': ConditionNpk.Low,
      'plantGrowthStage': PlantGrowthStage.Stage1
    };
    List<NotificationModel> notifications = [
      NotificationModel(id++, SensorType.dht11, StatusTemp.Low, dht1Value,
          "Low Temperature : 11",
          "The temperature of your plant is low, click on the notification tio see more details",
          false, DateTime(2022,10,08)
      ),
      NotificationModel(id++, SensorType.moisture, MoistureStatus.Moisturized, 85,
          "High Moisture : 85%",
          "The soil is over moisturized, click on the notification tio see more details",
          true, DateTime(2022,10,1)
      ),
      NotificationModel(id++, SensorType.pH, StatusPh.Acidic, 3.2,
          "Low pH : 3.2",
          "The soil is acidic, click on the notification tio see more details",
          true, DateTime(2022,9,25)
      ),
      NotificationModel(id++, SensorType.npk, npkStatus, npkValue,
          "NPK telemetry data problem",
          "Click on the notification tio see more details",
          true, DateTime(2022,8,16)
      ),
    ];
    prefs.setString('notifications',jsonEncode(notifications));
    print("SAVED");
  }

  void clearData(){
    prefs.remove('notifications');
    print("CLEARED");
  }

  // List<NotificationModel> getNotifications(){
  //   List<NotificationModel> notifications = [];
  //   String json = prefs.getString('notifications') ?? '[]';
  //   List<dynamic> jsonList = jsonDecode(json);
  //   for(dynamic e in jsonList){
  //     notifications.add(NotificationModel.fromJson(e));
  //   }
  //   notifications.sort((a, b) => b.time.compareTo(a.time));
  //
  //   return notifications;
  // }
  //
  // void updateNotifications(List<NotificationModel> notifications) async{
  //   await prefs.setString('notifications',jsonEncode(notifications));
  // }

  void markAsSeen(int id){
    List<NotificationModel> notifications = NotificationService().getNotifications();
    int index = notifications.indexOfId(id);
    if(index > -1){
      notifications[index].markAsSeen();
    }
    NotificationService().updateNotifications(notifications);
  }

  List<NotificationModel> getNotifications(){
    int id = 0;
    Map<String, dynamic> dht1Value = {
      'temperature': 11,
      'humidity': 80
    };
    Map<String, dynamic> npkValue = {
      'nitrogenValue': 20.1,
      'phosphorusValue': 30.5,
      'potassiumValue': 28.3
    };
    Map<String, dynamic> npkStatus = {
      'nitrogenCondition': ConditionNpk.Low,
      'phosphorusCondition': ConditionNpk.Good,
      'potassiumCondition': ConditionNpk.Low,
      'plantGrowthStage': PlantGrowthStage.Stage1
    };
    List<NotificationModel> notifications = [
      NotificationModel(id++, SensorType.dht11, StatusTemp.Low, dht1Value,
          "Low Temperature : 11",
          "The temperature of your plant is low, click on the notification tio see more details",
          false, DateTime.now().subtract(Duration(hours: 8))
      ),
      NotificationModel(id++, SensorType.moisture, MoistureStatus.Moisturized, 85,
          "High Moisture 85%",
          "The soil is over moisturized, click on the notification tio see more details",
          true, DateTime(2022,10,1,12,31)
      ),
      NotificationModel(id++, SensorType.pH, StatusPh.Acidic, 3.2,
          "Low pH : 3.2",
          "The soil is acidic, click on the notification tio see more details",
          false, DateTime(2022,9,25,23,13)
      ),
      NotificationModel(id++, SensorType.npk, npkStatus, npkValue,
          "NPK telemetry data problem",
          "Click on the notification tio see more details",
          true, DateTime(2022,8,16,07,6)
      ),
      NotificationModel(id++, SensorType.dht11, StatusTemp.Low, dht1Value,
          "High Temperature : 40",
          "The temperature of your plant is low, click on the notification tio see more details",
          true, DateTime(2022,8,03,10,18)
      ),
      NotificationModel(id++, SensorType.moisture, MoistureStatus.Moisturized, 85,
          "High Moisture 85%",
          "The soil is over moisturized, click on the notification tio see more details",
          true, DateTime(2022,07,26,14,48)
      ),
    ];

    return notifications;
  }
}
