import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings? settings;
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();

  factory FirebaseMessagingService() {
    return _instance;
  }

  FirebaseMessagingService._internal() {
    // initialization logic
  }

  Future<void> initService() async{
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid");
    // subscribe to topic on each app start-up
    await messaging.subscribeToTopic(uid ?? "demo");

    settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void setForegroundListener(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message}');

      if (message.notification != null) {
        print('Message also contained a notification:');
        print('Notif title: ${message.notification?.title}');
        print('Notif body: ${message.notification?.body}');

        NotificationService().savePushNotification(message);
      }
    });
  }

}