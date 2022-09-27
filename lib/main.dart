import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home.page.dart';
import 'package:internet_of_tomato_farming/pages/qrViewPage.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    await NotificationService().initNotification();
    await SensorsServices().dht11DataCallbackDispatcher();
    return Future.value(true);
  });
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  bool isLogged = await DeviceRepo.initializeFirebase();

  Workmanager().cancelAll();
  Workmanager().initialize(
      callbackDispatcher,
      // isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    "checkSensorData", "checkSensorData",
    frequency: Duration(minutes: 15),
    constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false
    )
  );

  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {

  MyApp({Key? key, required this.isLogged}) : super(key: key);
  bool isLogged = false;

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/qr': (context) => QRViewPage(),
    '/home': (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoTF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
        initialRoute: '/home'
      //initialRoute: (isLogged) ? '/home': '/qr',
    );
  }
}