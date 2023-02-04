import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_of_tomato_farming/main.dart';
import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/extensions.dart';
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

  Future<void> initService() async {
    prefs = await SharedPreferences.getInstance();
  }

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
          // MyApp.homePageKey.currentState?.onNotificationLaunchApp();
        }
    );
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
    MyApp.homePageKey.currentState!.setState(()=>null);
  }

  void savePushNotification(RemoteMessage message){
    List<NotificationModel> notifications = getNotifications();
    String id = message.messageId ?? DateTime.now().toIso8601String();

    var sensor = message.data["Sensor"];
    SensorType type = (sensor == "TempSoil" || sensor == "TempAir" || sensor == "Humidity") ? SensorType.dht11
        : (sensor == "Moisture") ? SensorType.moisture
        : (sensor == "Ph") ? SensorType.pH
        : (sensor == "N" || sensor == "P" || sensor == "K") ? SensorType.npk : SensorType.npk ;

    var status =
        (type == SensorType.dht11)
          ? (message.data["TypeOfAlert"]=="MIN") ? StatusTemp.Low : StatusTemp.High
        : (type == SensorType.pH)
          ? (message.data["TypeOfAlert"]=="MIN") ? StatusPh.Acidic : StatusPh.Alkaline
        : (type == SensorType.moisture)
          ? (message.data["TypeOfAlert"]=="MIN") ? MoistureStatus.Dry : MoistureStatus.Moisturized
        :{
          'nitrogenCondition': (message.data["TypeOfAlert"]=="MIN") ? ConditionNpk.Low : ConditionNpk.High,
          'phosphorusCondition': (message.data["TypeOfAlert"]=="MIN") ? ConditionNpk.Low : ConditionNpk.High,
          'potassiumCondition': (message.data["TypeOfAlert"]=="MIN") ? ConditionNpk.Low : ConditionNpk.High,
          'plantGrowthStage': PlantGrowthStage.Flowering
        };

    var dht11Value = {
      "temperature": (sensor == "TempSoil" || sensor == "TempAir") ? message.data["Value"] : "",
      "humidity": (sensor == "Humidity") ? message.data["Value"] : "",
    };

    var value = (type != SensorType.npk)
          ? (type == SensorType.dht11)
            ? dht11Value
            : message.data["Value"]
        : {
          'nitrogenValue': (sensor == "N") ? message.data["Value"] : "",
          'phosphorusValue': (sensor == "P") ? message.data["Value"] : "",
          'potassiumValue': (sensor == "K") ? message.data["Value"] : ""
        };

    var title = message.notification?.title ?? "";
    var body = "";
    var time = message.sentTime ?? DateTime.now();

    NotificationModel notification = NotificationModel(id, type, status, value, title, body, false, time);
    notifications.add(notification);
    updateNotifications(notifications);
  }

  Future<void> saveNotification(id,type, status, value, title, body, seen, time) async{
    List<NotificationModel> notifications = getNotifications();
    List<NotificationModel> tmp = List.from(notifications);
    tmp.retainWhere((element) => element.type==type);
    tmp.sort((a, b) => b.time.compareTo(a.time));

    if(tmp.isEmpty || (tmp.indexOfId(id) == -1
        && ((type == SensorType.dht11 && tmp.first.value['temperature'] != value['temperature'])
        || (type == SensorType.moisture && tmp.first.value != value)
        || (type == SensorType.pH && tmp.first.value != value)
        || (type == SensorType.npk && (tmp.first.value['nitrogenValue'] != value['nitrogenValue']
            || tmp.first.value['phosphorusValue'] != value['phosphorusValue']
            || tmp.first.value['potassiumValue'] != value['potassiumValue']))
        || (type == SensorType.disease && !tmp.first.time.isAtSameMomentAs(time))))
    ){
      // int id = getLastId();
      NotificationModel notification = NotificationModel(id, type, status, value, title, body, seen, time);
      notifications.add(notification);
      updateNotifications(notifications);
      // updateId(id);
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

  int getUnreadNotificationNumber(){
    List<NotificationModel> notifications = getNotifications();
    int unreadNotifications = 0;
    for(NotificationModel e in notifications){
      if(!e.seen) unreadNotifications++;
    }
    return unreadNotifications;
  }
}