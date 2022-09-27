import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:internet_of_tomato_farming/shared/extensions.dart';
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

  static Future initDevice(String uid1) async {
    DatabaseReference ref = database.reference().child('devices');

    await ref.update({
      uid1: {
        "createdAt": DateTime.now().toString()
      },
    }).then((value) async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("uid", uid1);
      uid = uid1;
    });
  }



  Query getTemperatureAndHumidityData() {
    //TODO to be removed
    uid = '1999';
    final Query dht11History = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("DHT11").orderByChild('dateInt');
    return dht11History;
  }

  Query getDht11DataLast15min() {
    //TODO to be removed
    uid = '1999';
    DateTime before15min = DateTime.now().subtract(const Duration(minutes: 15));
    final Query dht11History = FirebaseDatabase.instance.reference()
        .child('devices').child(uid!).child("DHT11").orderByChild('Date')
        .startAt(before15min.toDateInt());
    return dht11History;
  }

  Query getPhData() {
    //TODO to be removed
    uid = '1999';
    final Query dht11History = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("Ph").orderByChild('dateInt');
    return dht11History;
  }

  Query getMoistureData() {
    //TODO to be removed
    uid = '1999';
    final Query dht11History = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("Moisture").orderByChild('dateInt');
    return dht11History;
  }
}