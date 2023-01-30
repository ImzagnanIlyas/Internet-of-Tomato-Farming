import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseHelperRepo {

  Future<void> saveThresholds(Map<String, dynamic> data) async {
    var db = FirebaseFirestore.instance;

    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid");

    db.collection("usersData")
        .doc(uid)
        .set(data)
        .onError((e, _) => print("Error writing document: $e"));
  }
}