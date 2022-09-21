
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRepo {
  static late FirebaseApp firebaseApp;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static String? uid;

  static Future<bool> initializeFirebase() async {
    firebaseApp = await Firebase.initializeApp();
    var prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid");
    if(uid != null) return true;
    return false;
  }

  static Future initDevice(String uid) async {
    DatabaseReference ref = database.ref('devices');

    await ref.update({
      uid: {
        "createdAt": DateTime.now().toString()
      },
    }).then((value) async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", uid);
    });
  }

}