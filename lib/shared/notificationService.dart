import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
     tz.initializeTimeZones();
     //tz.setLocalLocation(tz.getLocation(locationName));
    // Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    // the date of the appointment acts as the id of it
    String dateIntString  = DateFormat('yyyy/MM/dd').format(tz.TZDateTime.now(tz.local)).replaceAll('/', '');
    int dateInt = int.parse(dateIntString);
    print('dateInt in showNotification $dateInt');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      dateInt,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(days: 0, seconds : 1)), //schedule the notification to show after
      const NotificationDetails(
        // Android details
        android: AndroidNotificationDetails('main_channel', 'Main Channel', 'ashwin'),
        // AndroidNotificationDetails('main_channel', 'Main Channel',
        //     channelDescription: "ashwin",
        //     importance: Importance.max,
        //     priority: Priority.max)
        // iOS details
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true, // To show notification even when the app is closed
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> cancelNotifications(String dateIntString) async {
    DateTime dt = new DateFormat("dd-MM-yyyy").parse(dateIntString);
    String dateIntString2  = DateFormat('yyyy/MM/dd').format(dt).replaceAll('/', '');
    int dateInt = int.parse(dateIntString2);
    //print('dateInt in cancelNotifications $dateInt');
    await flutterLocalNotificationsPlugin.cancel(dateInt);
  }
}