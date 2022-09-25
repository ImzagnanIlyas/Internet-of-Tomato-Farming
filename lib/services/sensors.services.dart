import '../shared/notificationService.dart';

enum StatusTemp {High, Low, Good, Ideal}

class SensorsServices {

  Map<Map<String, String>, StatusTemp> response = {};

  static StatusTemp FilterTemperatureAndTriggerNotif(double temperature){

    if(temperature < 12) {
      NotificationService().showNotification("Low Temperature : $temperature", "The temperature of your plant is low, click on the notification tio see more details");
      return StatusTemp.Low;
    }
    if(temperature > 35) {
      NotificationService().showNotification("High Temperature : $temperature", "The temperature of your plant is high, click on the notification tio see more details");
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



}