import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_of_tomato_farming/pages/home.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/moistureNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/npkDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/phNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/temp&HumNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifications/notifications.page.dart';
import 'package:internet_of_tomato_farming/pages/npk/npkForm.ui.dart';
import 'package:internet_of_tomato_farming/pages/qrViewPage.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    await NotificationService().initNotification();
    SensorsServices sensorsService = SensorsServices();
    await sensorsService.dht11DataCallbackDispatcher();
    await sensorsService.moistureDataCallbackDispatcher();
    await sensorsService.phDataCallbackDispatcher();
    await sensorsService.npkDataCallbackDispatcher();
    await sensorsService.diseaseDataCallbackDispatcher();
    return Future.value(true);
  });
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool didNotificationLaunchApp = await NotificationService().initNotification();
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

  runApp(MyApp(isLogged: isLogged, didNotificationLaunchApp: didNotificationLaunchApp));
}

class MyApp extends StatelessWidget {

  bool isLogged = false;
  static final homePageKey = GlobalKey<HomePageState>();
  late final Map<String, Widget Function(BuildContext)> routes;
  bool didNotificationLaunchApp;

  MyApp({Key? key, required this.isLogged, this.didNotificationLaunchApp = false}) :super(key: key){
    routes = {
      '/qr': (context) => QRViewPage(),
      '/home': (context) => HomePage(key: homePageKey,didNotificationLaunchApp: didNotificationLaunchApp),
      '/tempAndHumNotifDisplay': (context) => TempAndHumNotifDisplay(StatusTemp.Low, 39, 16),
      '/phNotifDisplay': (context) => PhNotifDisplay(11.1, StatusPh.Acidic),
      '/npkNotifDisplay': (context) => NpkNotifDisplay(ConditionNpk.Low, ConditionNpk.Good, ConditionNpk.Low, 20, 30, 28, PlantGrowthStage.Vegetative),
      '/npkForm': (context) => NpkForm(),
      '/moistureNotifDisplay': (context) => MoistureNotifDisplay(MoistureStatus.Dry, 30),
      '/notifications': (context) => NotificationsPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoTF',
      theme: ThemeData(
        primaryColor: Colors.lightGreen
      ),
      routes: routes,
      initialRoute: '/qr',
        //initialRoute: '/phNotifDisplay'
      // initialRoute: (isLogged) ? '/home': '/qr',
    );
  }

}