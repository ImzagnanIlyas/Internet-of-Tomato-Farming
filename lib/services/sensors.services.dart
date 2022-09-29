import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';

import '../shared/notificationService.dart';

enum StatusTemp {High, Low, Good, Ideal}
enum StatusPh {Acidic, Alkaline}

class SensorsServices {

  Map<Map<String, String>, StatusTemp> response = {};
  static const int ID_TEMP = 1;

  static StatusTemp FilterTemperatureAndTriggerNotif(int temperature){

    if(temperature < 12) {
      NotificationService().showNotification(ID_TEMP,"Low Temperature : $temperature", "The temperature of your plant is low, click on the notification tio see more details");
      return StatusTemp.Low;
    }
    if(temperature > 35) {
      NotificationService().showNotification(ID_TEMP,"High Temperature : $temperature", "The temperature of your plant is high, click on the notification tio see more details");
      return StatusTemp.High;
    }
    if(temperature >= 20 && temperature <= 24){
      return StatusTemp.Ideal;
    }
    if(temperature > 12 && temperature < 24){
      return StatusTemp.Good;
    }
    return StatusTemp.Good;
  }

  /// used in background process
  Future dht11DataCallbackDispatcher() async{
    var values = (await DeviceRepo().getDht11DataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        Dht11Model data = Dht11Model.fromJson(value);
        FilterTemperatureAndTriggerNotif(data.temperature);
      });
    }
  }


}