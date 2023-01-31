import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepo{
  static String? pid; // product id

  void initService() async {
    var prefs = await SharedPreferences.getInstance();
    pid = prefs.getString("uid");
  }

  /**
   * Get firebase real time database stream for aggregation data
   * */
  Stream<DatabaseEvent> getAggregationDataStream(){
    return FirebaseDatabase.instance
        .ref('products/$pid/aggregation')
        .onValue;
  }


}