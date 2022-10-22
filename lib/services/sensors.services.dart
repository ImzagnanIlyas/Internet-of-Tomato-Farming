import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:internet_of_tomato_farming/shared/preferencesService.dart';

import '../shared/notificationService.dart';
import 'package:intl/intl.dart';

enum StatusTemp {High, Low, Good, Ideal, None}
enum StatusPh {Acidic, Alkaline, Good}
enum StatusNpk {N, P, K}
enum ConditionNpk {High, Low, Good}
enum PlantGrowthStage{Stage1, Stage2, Stage3}
enum MoistureStatus{Good, Moisturized, Dry}
enum SensorType{dht11, moisture, pH, npk}

class SensorsServices {

  static const int ID_TEMP = 1;
  final preferenceService = PreferencesService();

  StatusTemp FilterTemperatureAndTriggerNotif(int temperature, int humidity){
    if(temperature < 12)  return StatusTemp.Low;
    if(temperature > 35)  return StatusTemp.High;
    return StatusTemp.Good;
  }

  static MoistureStatus moistureFilter(int moistureValue){
    if(moistureValue < 60 )  return MoistureStatus.Dry;
    if(moistureValue > 80 )  return MoistureStatus.Moisturized;
    return MoistureStatus.Good;
  }

  static StatusPh phFilter(int phValue){
    if(phValue < 6)  return StatusPh.Acidic;
    if(phValue > 8)  return StatusPh.Alkaline;
    else return StatusPh.Good;
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

  ///////////////////////////////////////

  /// used in background process
  Future dht11DataCallbackDispatcher() async{
    var values = (await DeviceRepo().getDht11DataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        Dht11Model data = Dht11Model.fromJson(value);
        dh11DataObserver(data.temperature, data.humidity);
      });
    }
  }

  /// used in dh11Repo & dht11DataCallbackDispatcher
  void dh11DataObserver(int temperature, int humidity){
    StatusTemp status = FilterTemperatureAndTriggerNotif(temperature, humidity);
    if(status==StatusTemp.Low || status==StatusTemp.High){
      SensorType type = SensorType.dht11;
      Map<String, dynamic> value = {
        'temperature': temperature,
        'humidity': humidity
      };
      String title = "Low Temperature : "+temperature.toString();
      String body = "The temperature of your plant is low, click on the notification tio see more details";
      if(status==StatusTemp.High) {
        title = "High Temperature : "+temperature.toString();
        body = "The temperature of your plant is high, click on the notification tio see more details";
      }
      NotificationService notificationService = NotificationService();
      notificationService.showNotification(ID_TEMP, title, body);
      notificationService.saveNotification(type, status, value, title, body, false, DateTime.now());
    }
  }
}