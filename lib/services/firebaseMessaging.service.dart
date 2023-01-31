import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void initService() async{
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid");
    // subscribe to topic on each app start-up
    await messaging.subscribeToTopic(uid ?? "");
  }

}