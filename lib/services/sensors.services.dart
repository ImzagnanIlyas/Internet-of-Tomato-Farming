import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:internet_of_tomato_farming/shared/preferencesService.dart';

import '../shared/notificationService.dart';
import 'package:intl/intl.dart';

enum StatusTemp {High, Low, Good, Ideal, None}
enum StatusPh {Acidic, Alkaline}
enum StatusNpk {N, P, K}
enum ConditionNpk {High, Low, Good}
enum PlantGrowthStage{Stage1, Stage2, Stage3}
enum MoistureStatus{Good, Moisturized, Dry}
enum SensorType{dht11, moisture, pH, npk}

class SensorsServices {

  static const int ID_TEMP = 1;
  final preferenceService = PreferencesService();

  void FilterTemperatureAndTriggerNotif(int temperature, int humidity){
    SensorType type = SensorType.dht11;
    Map<String, dynamic> value = {
      'temperature': temperature,
      'humidity': humidity
    };
    if(temperature < 12) {
      StatusTemp status = StatusTemp.Low;
      String title = "Low Temperature : $temperature";
      String body = "The temperature of your plant is low, click on the notification tio see more details";
      NotificationService().showNotification(
        ID_TEMP,
        title,
        body
      );
      NotificationService().saveNotification(type, status, value, title, body, false, DateTime.now());
      return ;
    }
    if(temperature > 35) {
      StatusTemp status = StatusTemp.High;
      String title = "High Temperature : $temperature";
      String body = "The temperature of your plant is high, click on the notification tio see more details";
      NotificationService().showNotification(ID_TEMP,title, body);
      NotificationService().saveNotification(type, status, value, title, body, false, DateTime.now());
    }
    // if(temperature >= 20 && temperature <= 24){
    //   return StatusTemp.Ideal;
    // }
    // if(temperature > 12 && temperature < 24){
    //   return StatusTemp.Good;
    // }
    // return StatusTemp.None;
  }

  static MoistureStatus moistureFilter(int moistureValue){
    if(moistureValue < 60 )  return MoistureStatus.Dry;
    if(moistureValue > 80 )  return MoistureStatus.Moisturized;
    return MoistureStatus.Good;
  }

  /// used in background process
  Future dht11DataCallbackDispatcher() async{
    var values = (await DeviceRepo().getDht11DataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        Dht11Model data = Dht11Model.fromJson(value);
        FilterTemperatureAndTriggerNotif(data.temperature, data.humidity);
      });
    }
  }


  List<dynamic> npkFilter(double N, double P, double K, plantingDateString, massOfSoil) {

    DateTime plantingDate = DateFormat('dd-MM-yyyy').parse(plantingDateString);
    int weekOfPlanting = weeksBetween(plantingDate, DateTime.now());

    double NinKgPerHa = massOfSoil * (N / 1000000);
    double PinKgPerHa = massOfSoil * (P / 1000000);
    double KinKgPerHa = massOfSoil * (K / 1000000);

    print('current values : N = $NinKgPerHa, P = $PinKgPerHa, K = $KinKgPerHa');
    print('weeks passed : $weekOfPlanting');

    List<double> firstInterval = [0,5];
    List<double> secondInterval = [6,12];
    List<double> thirdInterval = [13,20];

    dynamic firstIntervalNitrogenValues = {'operator' :  'Min', 'values' : [95]};
    dynamic firstIntervalPhosphorusValues = {'operator' :  'Min', 'values' : [68]};
    dynamic firstIntervalPotassiumValues = {'operator' :  'Min', 'values' : [130]};

    dynamic secondIntervalNitrogenValues = {'operator' :  'Min', 'values' : [150]};
    dynamic secondIntervalPhosphorusValues = {'operator' :  'Min', 'values' : [80]};
    dynamic secondIntervalPotassiumValues = {'operator' :  'Min', 'values' : [240]};

    dynamic thirdIntervalNitrogenValues = {'operator' :  'Min', 'values' : [220]};
    dynamic thirdIntervalPhosphorusValues = {'operator' :  'Min', 'values' : [98]};
    dynamic thirdIntervalPotassiumValues = {'operator' :  'Min', 'values' : [360]};

    var intervalNitrogenValues;
    var IntervalPhosphorusValues;
    var IntervalPotassiumValues;

    if(weekOfPlanting >= firstInterval[0] && weekOfPlanting <= firstInterval[1]){
      intervalNitrogenValues = firstIntervalNitrogenValues;
      IntervalPhosphorusValues = firstIntervalPhosphorusValues;
      IntervalPotassiumValues = firstIntervalPotassiumValues;
    }
    if(weekOfPlanting >= secondInterval[0] && weekOfPlanting <= secondInterval[1]){
      intervalNitrogenValues = secondIntervalNitrogenValues;
      IntervalPhosphorusValues = secondIntervalPhosphorusValues;
      IntervalPotassiumValues = secondIntervalPotassiumValues;
    }
    if(weekOfPlanting >= thirdInterval[0] && weekOfPlanting <= thirdInterval[1]){
      intervalNitrogenValues = thirdIntervalNitrogenValues;
      IntervalPhosphorusValues = thirdIntervalPhosphorusValues;
      IntervalPotassiumValues = thirdIntervalPotassiumValues;
    }

    List<dynamic> results = [];

    if(intervalNitrogenValues['operator'] == 'Min'){
      if(NinKgPerHa < intervalNitrogenValues['values'][0]) results.add({'nutrient' : 'N', 'operator' : 'Min', 'value' : NinKgPerHa, 'shouldBe' : intervalNitrogenValues['values'][0]});
    }else if(intervalNitrogenValues['operator'] == 'Max'){
      if(NinKgPerHa > intervalNitrogenValues['values'][0]) results.add({'nutrient' : 'N', 'operator' : 'Max', 'value' : NinKgPerHa, 'shouldBe' : intervalNitrogenValues['values'][0]});
    }else{
      if(NinKgPerHa < intervalNitrogenValues['values'][0] || NinKgPerHa > intervalNitrogenValues['values'][1]) results.add({'nutrient' : 'N', 'operator' : 'Bet', 'value' : NinKgPerHa, 'shouldBe' : intervalNitrogenValues['values']});
    }

    if(IntervalPhosphorusValues['operator'] == 'Min'){
      if(PinKgPerHa < IntervalPhosphorusValues['values'][0]) results.add({'nutrient' : 'P', 'operator' : 'Min', 'value' : PinKgPerHa, 'shouldBe' : IntervalPhosphorusValues['values'][0]});
    }else if(IntervalPhosphorusValues['operator'] == 'Max'){
      if(PinKgPerHa > IntervalPhosphorusValues['values'][0]) results.add({'nutrient' : 'P', 'operator' : 'Max', 'value' : PinKgPerHa, 'shouldBe' : IntervalPhosphorusValues['values'][0]});
    }else{
      if(PinKgPerHa < IntervalPhosphorusValues['values'][0] || PinKgPerHa > IntervalPhosphorusValues['values'][1]) results.add({'nutrient' : 'P', 'operator' : 'Bet', 'value' : PinKgPerHa, 'shouldBe' : IntervalPhosphorusValues['values']});
    }

    if(IntervalPotassiumValues['operator'] == 'Min'){
      if(KinKgPerHa < IntervalPotassiumValues['values'][0]) results.add({'nutrient' : 'K', 'operator' : 'Min', 'value' : KinKgPerHa, 'shouldBe' : IntervalPotassiumValues['values'][0]});
    }else if(IntervalPotassiumValues['operator'] == 'Max'){
      if(KinKgPerHa > IntervalPotassiumValues['values'][0]) results.add({'nutrient' : 'K', 'operator' : 'Max', 'value' : KinKgPerHa, 'shouldBe' : IntervalPotassiumValues['values'][0]});
    }else{
      if(KinKgPerHa < IntervalPotassiumValues['values'][0] || KinKgPerHa > IntervalPotassiumValues['values'][1])  results.add({'nutrient' : 'K', 'operator' : 'Bet', 'value' : KinKgPerHa, 'shouldBe' : IntervalPotassiumValues['values']});
    }

    return results;
  }

  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).round();
  }

}