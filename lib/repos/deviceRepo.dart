import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:internet_of_tomato_farming/shared/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
    child('devices').child(uid!).child("DHT11").orderByChild('Date').limitToLast(1);
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
    child('devices').child(uid!).child("Ph").orderByChild('Date').limitToLast(1);
    return dht11History;
  }

  Query getPhDataLast15min() {
    //TODO to be removed
    uid = '1999';
    DateTime before15min = DateTime.now().subtract(const Duration(minutes: 15));
    final Query dht11History = FirebaseDatabase.instance.reference()
        .child('devices').child(uid!).child("Ph").orderByChild('Date')
        .startAt(before15min.toDateInt());
    return dht11History;
  }

  Query getMoistureData() {
    //TODO to be removed
    uid = '1999';
    final Query dht11History = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("Moisture").orderByChild('Date').limitToLast(1);
    return dht11History;
  }

  Query getMoistureDataLast15min() {
    //TODO to be removed
    uid = '1999';
    DateTime before15min = DateTime.now().subtract(const Duration(minutes: 15));
    final Query history = FirebaseDatabase.instance.reference()
        .child('devices').child(uid!).child("Moisture").orderByChild('Date')
        .startAt(before15min.toDateInt());
    return history;
  }

  Query getNpkData() {
    //TODO to be removed
    uid = '1999';
    final Query npkHistory = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("NPK").orderByChild('Date').limitToLast(1);
    return npkHistory;
  }

  Query getNpkDataLast15min() {
    //TODO to be removed
    uid = '1999';
    DateTime before15min = DateTime.now().subtract(const Duration(minutes: 15));
    final Query history = FirebaseDatabase.instance.reference()
        .child('devices').child(uid!).child("NPK").orderByChild('Date')
        .startAt(before15min.toDateInt());
    return history;
  }

  Query getDiseaseData() {
    //TODO to be removed
    uid = '1999';
    final Query npkHistory = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("Classification").orderByChild('dateInt').limitToLast(1);
    return npkHistory;
  }

  Query getDiseaseDataLast15min() {
    uid = '1999';
    DateTime before15min = DateTime.now().subtract(const Duration(minutes: 15));
    final Query history = FirebaseDatabase.instance.reference()
        .child('devices').child(uid!).child("Classification").orderByChild('dateInt')
        .startAt(before15min.toDateInt());
    return history;
  }

  Query getDiseaseDataByTime(DateTime time) {
    int dateInt = dateToDateInt(time);
    //TODO to be removed
    uid = '1999';
    final Query npkHistory = FirebaseDatabase.instance.reference().
    child('devices').child(uid!).child("Classification").orderByChild('dateInt')
        .equalTo(dateInt);
    return npkHistory;
  }

  int dateToDateInt(DateTime date){
    String s = DateFormat("yMMddHHmmss").format(date);
    return int.parse(s);
  }

}