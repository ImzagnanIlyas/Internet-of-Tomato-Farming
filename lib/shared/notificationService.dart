import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_of_tomato_farming/main.dart';
import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  late var prefs;

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<bool> initNotification() async {
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
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: (payload) async{
          MyApp.homePageKey.currentState?.onNotificationLaunchApp();
        }
    );
    prefs = await SharedPreferences.getInstance();
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

    return didNotificationLaunchApp;
  }

  Future<void> showNotification(int id, String title, String body) async {
    String dateIntString  = DateFormat('yyyyMMdd').format(tz.TZDateTime.now(tz.local)); // 235,959,999
    int notifId = int.parse(id.toString()+dateIntString);
    print('dateInt in showNotification $notifId');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notifId,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(days: 0, seconds : 1)), //schedule the notification to show after
      NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel', 'Main Channel', 'ashwin',
            styleInformation: BigTextStyleInformation(body)
        ),
        iOS: IOSNotificationDetails(
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

  List<NotificationModel> getNotifications() {
    List<NotificationModel> notifications = [];
    String json = prefs.getString('notifications') ?? '[]';
    List<dynamic> jsonList = jsonDecode(json);
    for(dynamic e in jsonList){
      notifications.add(NotificationModel.fromJson(e));
    }
    notifications.sort((a, b) => b.time.compareTo(a.time));

    return notifications;
  }

  void updateNotifications(List<NotificationModel> notifications) async{
    await prefs.setString('notifications',jsonEncode(notifications));
  }

  Future<void> saveNotification(type, status, value, title, body, seen, time) async{
    List<NotificationModel> notifications = getNotifications();
    List<NotificationModel> tmp = List.from(notifications);
    tmp.retainWhere((element) => element.type==type);
    tmp.sort((a, b) => b.time.compareTo(a.time));

    if(tmp.isEmpty
        || (type == SensorType.dht11 && tmp.first.value['temperature'] != value['temperature'])
        || (type == SensorType.moisture && tmp.first.value != value)
        || (type == SensorType.pH && tmp.first.value != value)
        || (type == SensorType.npk && (tmp.first.value['nitrogenValue'] != value['nitrogenValue']
            || tmp.first.value['phosphorusValue'] != value['phosphorusValue']
            || tmp.first.value['potassiumValue'] != value['potassiumValue']))
        || (type == SensorType.disease && !tmp.first.time.isAtSameMomentAs(time))
    ){
      int id = getLastId();
      NotificationModel notification = NotificationModel(id++, type, status, value, title, body, seen, time);
      notifications.add(notification);
      updateNotifications(notifications);
      updateId(id);
    }
  }

  int getLastId(){
    int id = prefs.getInt('notificationID');
    if(id == null){
      prefs.setInt('notificationID', 0);
      return 0;
    }
    return id;
  }

  void updateId(int id){
    prefs.setInt('notificationID', id);
  }
}