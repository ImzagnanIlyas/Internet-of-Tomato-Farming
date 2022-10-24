import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/pages/models/disease.model.dart';
import 'package:internet_of_tomato_farming/pages/models/moisture.model.dart';
import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:internet_of_tomato_farming/pages/models/ph.model.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:internet_of_tomato_farming/shared/preferencesService.dart';

import '../pages/models/npk.model.dart';
import '../shared/notificationService.dart';
import 'package:intl/intl.dart';

enum StatusTemp {High, Low, Good, Ideal, None}
enum StatusPh {Acidic, Alkaline, Good}
enum StatusNpk {N, P, K}
enum ConditionNpk {High, Low, Good}
enum PlantGrowthStage{Vegetative, Flowering, Fruit}
enum MoistureStatus{Good, Moisturized, Dry}
enum SensorType{dht11, moisture, pH, npk, disease}

class SensorsServices {

  static const int ID_TEMP = 1;
  static const int ID_MOISTURE = 2;
  static const int ID_PH = 3;
  static const int ID_NPK = 4;
  static const int ID_DISEASE = 5;
  final preferenceService = PreferencesService();

  StatusTemp FilterTemperatureAndTriggerNotif(double temperature, double humidity){
    if(temperature < 12)  return StatusTemp.Low;
    if(temperature > 35)  return StatusTemp.High;
    return StatusTemp.Good;
  }

  static MoistureStatus moistureFilter(double moistureValue){
    if(moistureValue < 60 )  return MoistureStatus.Dry;
    if(moistureValue > 80 )  return MoistureStatus.Moisturized;
    return MoistureStatus.Good;
  }

  static StatusPh phFilter(double phValue){
    if(phValue < 6)  return StatusPh.Acidic;
    if(phValue > 8)  return StatusPh.Alkaline;
    else return StatusPh.Good;
  }

  List<dynamic> npkFilter(double NinKgPerHa, double PinKgPerHa, double KinKgPerHa, plantingDateString) {

    DateTime plantingDate = DateFormat('dd-MM-yyyy').parse(plantingDateString);
    int weekOfPlanting = weeksBetween(plantingDate, DateTime.now());

/*    double NinKgPerHa = massOfSoil * (N / 1000000);
    double PinKgPerHa = massOfSoil * (P / 1000000);
    double KinKgPerHa = massOfSoil * (K / 1000000);*/

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

  // disease exist => return true
  bool diseaseFilter(String state){
    return state != 'Healthy';
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
  void dh11DataObserver(double temperature, double humidity){
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

  Future moistureDataCallbackDispatcher() async{
    var values = (await DeviceRepo().getMoistureDataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        MoistureModel data = MoistureModel.fromJson(value);
        moistureDataObserver(data.value);
      });
    }
  }

  void moistureDataObserver(double value){
    MoistureStatus status = moistureFilter(value);
    if(status==MoistureStatus.Dry || status==MoistureStatus.Moisturized){
      SensorType type = SensorType.moisture;
      String title = "Low Moisture : "+value.toString()+'%';
      String body = "The soil is over moisturized, click on the notification tio see more details";
      if(status==MoistureStatus.Moisturized) {
        title = "High Moisture : "+value.toString()+'%';
        body = "The soil is dry, click on the notification tio see more details";
      }
      NotificationService().showNotification(ID_MOISTURE, title, body);
      NotificationService().saveNotification(type, status, value, title, body, false, DateTime.now());
    }
  }

  Future phDataCallbackDispatcher() async{
    var values = (await DeviceRepo().getPhDataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        PhModel data = PhModel.fromJson(value);
        phDataObserver(data.value);
      });
    }
  }

  void phDataObserver(double value){
    StatusPh status = phFilter(value);
    if(status==StatusPh.Acidic || status==StatusPh.Alkaline){
      SensorType type = SensorType.pH;
      String title = "Low pH : "+value.toString();
      String body = "The soil is acidic, click on the notification tio see more details";
      if(status==StatusPh.Alkaline) {
        title = "High pH : "+value.toString();
        body = "The soil is alkaline, click on the notification tio see more details";
      }
      NotificationService().showNotification(ID_PH, title, body);
      NotificationService().saveNotification(type, status, value, title, body, false, DateTime.now());
    }
  }

  Future npkDataCallbackDispatcher() async{
    var values = (await DeviceRepo().getNpkDataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        NPKModel data = NPKModel.fromJson(value);
        npkDataObserver(data);
      });
    }
  }

  void npkDataObserver(NPKModel data) async{
    PreferencesService service = PreferencesService();
    // FOR TEST
    // await service.savePlantingDate(DateTime.now());
    // await service.saveMassSoil(150);
    var plantingDate = await service.getPlantingDate();
    //var massOfSoil = await service.getMassSoil();
    if(plantingDate != null ){
      List<dynamic> results = npkFilter(data.n, data.p, data.k, plantingDate);
      print("results length ::: "+results.length.toString());
      if(results.isNotEmpty){
        print("results ::: "+results.toString());
        SensorType type = SensorType.npk;
        Map<String, dynamic> npkValue = {
          'nitrogenValue': data.n,
          'phosphorusValue': data.p,
          'potassiumValue': data.k
        };
        var nC = ConditionNpk.Good;
        var pC = ConditionNpk.Good;
        var kC = ConditionNpk.Good;
        for(dynamic e in results){
          if(e['nutrient'] == 'N'){
            nC = ConditionNpk.Low;
          }
          if(e['nutrient'] == 'P'){
            pC = ConditionNpk.Low;
          }
          if(e['nutrient'] == 'K'){
            kC = ConditionNpk.Low;
          }
        }
        Map<String, dynamic> npkStatus = {
          'nitrogenCondition': nC,
          'phosphorusCondition': pC,
          'potassiumCondition': kC,
          'plantGrowthStage': getPlantGrowthStage(plantingDate)
        };
        String title = "Nutrients telemetry data problem";
        String body = "Click on the notification tio see more details";
        NotificationService().showNotification(ID_NPK, title, body);
        NotificationService().saveNotification(type, npkStatus, npkValue, title, body, false, DateTime.now());
      }
    }
  }

  PlantGrowthStage getPlantGrowthStage(String plantingDateString){
    List<double> firstInterval = [0,5];
    List<double> secondInterval = [6,12];
    List<double> thirdInterval = [13,20];
    DateTime plantingDate = DateFormat('dd-MM-yyyy').parse(plantingDateString);
    int weekOfPlanting = weeksBetween(plantingDate, DateTime.now());

    if(weekOfPlanting >= firstInterval[0] && weekOfPlanting <= firstInterval[1]){
      return PlantGrowthStage.Vegetative;
    }
    if(weekOfPlanting >= secondInterval[0] && weekOfPlanting <= secondInterval[1]){
      return PlantGrowthStage.Flowering;
    }
    if(weekOfPlanting >= thirdInterval[0] && weekOfPlanting <= thirdInterval[1]){
      return PlantGrowthStage.Fruit;
    }

    return PlantGrowthStage.Vegetative;
  }

  Future diseaseDataCallbackDispatcher() async{
    var values = (await DeviceRepo().getDiseaseDataLast15min().once()).value;
    if(values != null) {
      values.forEach((key, value) {
        DiseaseModel data = DiseaseModel.fromJson(value);
        diseaseDataObserver(data);
      });
    }
  }

  void diseaseDataObserver(DiseaseModel data){
    bool status = diseaseFilter(data.state);
    if(status){
      SensorType type = SensorType.disease;
      String title = "Disease Detected : "+data.state;
      String body = "Click on the notification tio see more details";
      NotificationService().showNotification(ID_DISEASE, title, body);
      NotificationService().saveNotification(type, data.state, null, title, body, false, data.date);
    }
  }
}