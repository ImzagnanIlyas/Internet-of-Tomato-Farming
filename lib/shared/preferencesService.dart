import 'dart:convert';
import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {


  Future  savePlantingDate(DateTime plantingDate) async {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String plantingDateString = dateFormat.format(plantingDate);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('plantingDate', plantingDateString);
    print('savePlantingDate Done');
  }

  Future<String?> getPlantingDate() async {
    final preferences = await SharedPreferences.getInstance();
    String? plantingDateString = preferences.getString('plantingDate');
    print('getPlantingDate Done');
    return plantingDateString;
  }

  Future  saveMassSoil(double massSoil) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble('MassSoil', massSoil);
    print('saveMassSoil Done');
  }

  Future<double?> getMassSoil() async {
    final preferences = await SharedPreferences.getInstance();
    double? massSoil = preferences.getDouble('MassSoil');
    print('getMassSoil Done');
    return massSoil;
  }
}