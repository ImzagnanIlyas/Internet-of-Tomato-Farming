import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home.page.dart';
import 'package:internet_of_tomato_farming/pages/home/dashboard.page.dart';
import 'package:internet_of_tomato_farming/pages/initial-info/thresholdsForm.ui.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/moistureNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/npkDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/phNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/temp&HumNotifDisplay.page.dart';
import 'package:internet_of_tomato_farming/pages/notifications/notifications.page.dart';
import 'package:internet_of_tomato_farming/pages/npk/npkForm.ui.dart';
import 'package:internet_of_tomato_farming/pages/qrViewPage.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:internet_of_tomato_farming/services/firebaseMessaging.service.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:workmanager/workmanager.dart';

import 'pages/initial-info/gridForm.ui.dart';

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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  if (message.notification != null) {
    print('Message also contained a notification:');
    print('Notif title: ${message.notification?.title}');
    print('Notif body: ${message.notification?.body}');
    NotificationService().savePushNotification(message);
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await DeviceRepo.initializeFirebase();
  await FirebaseMessagingService().initService();
  FirebaseMessagingService().setForegroundListener();
  NotificationService().initService();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp(isLogged: isLogged, didNotificationLaunchApp: false));
}

class MyApp extends StatelessWidget {

  bool isLogged = false;
  static final homePageKey = GlobalKey<DashboardState>();
  late final Map<String, Widget Function(BuildContext)> routes;
  bool didNotificationLaunchApp;

  MyApp({Key? key, required this.isLogged, this.didNotificationLaunchApp = false}) :super(key: key){
    routes = {
      '/qr': (context) => QRViewPage(),
      '/thresholdsForm': (context) => ThresholdsForm(),
      '/gridForm': (context) => GridForm(),
      '/home': (context) => Dashboard(key: homePageKey),
      '/tempAndHumNotifDisplay': (context) => TempAndHumNotifDisplay(StatusTemp.Low, 39, 16),
      '/phNotifDisplay': (context) => PhNotifDisplay(11.1, StatusPh.Acidic),
      // '/npkNotifDisplay': (context) => NpkNotifDisplay(ConditionNpk.Low, ConditionNpk.Good, ConditionNpk.Low, 20, 30, 28, PlantGrowthStage.Vegetative),
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
        primarySwatch: Colors.green
      ),
      routes: routes,
      initialRoute: '/home',
      // initialRoute: (isLogged) ? '/home': '/qr',
    );
  }

}