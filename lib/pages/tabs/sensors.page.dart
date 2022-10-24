import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/NpkSensor.ui.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/temperature.ui.dart';
import 'package:internet_of_tomato_farming/pages/models/npk.model.dart';
import 'package:internet_of_tomato_farming/pages/models/ph.model.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../repos/deviceRepo.dart';
import '../../services/sensors.services.dart';
import '../../shared/toasts.dart';
import '../home/ui/humidity.ui.dart';
import '../home/ui/ph.ui.dart';
import '../models/dht11.model.dart';
import '../models/moisture.model.dart';

class SensorTab extends StatefulWidget {
  @override
  State<SensorTab> createState() => _SensorTabState();
}

class _SensorTabState extends State<SensorTab> {
  final _deviceRepo = DeviceRepo();
  final _toast = ToastMsg();
  final tempValue = new ValueNotifier<double>(0);
  final humidityValue = new ValueNotifier<double>(0);
  final phValue = new ValueNotifier<double>(0);
  final npkValues = new ValueNotifier<List<double>>([0, 0, 0]);
  final nValue = new ValueNotifier<double>(0);
  final pValue = new ValueNotifier<double>(0);
  final kValue = new ValueNotifier<double>(0);


  List<Dht11Model> dht11Data = [];
  List<MoistureModel> moistureData = [];
  List<PhModel> phData = [];
  List<NPKModel> npkData = [];


  late String _now;
  late Timer _everySecond;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _now = DateTime.now().second.toString();
    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 10), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
        //print(_now);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: _deviceRepo.getTemperatureAndHumidityData().once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    dht11Data.clear();
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> values = snapshot.data!.value;
                      if (values == null) {
                        Dht11Model data = Dht11Model(0, 0, 0);
                        dht11Data.add(data);
                        _toast.showMsg(
                            'No temperature and humidity data to be shown');
                      } else {
                        values.forEach((key, values) {
                          Dht11Model data = Dht11Model.fromJson(values);
                          dht11Data.add(data);
                          // //print(data);
                        });
                      }
                      tempValue.value = dht11Data.last.temperature.toDouble();
                      humidityValue.value = dht11Data.last.humidity.toDouble();
                      // print(tempValue.value);
                      // print(humidityValue.value);
                      //print(dht11Data.last);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Temperature',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Card(
                                  shadowColor: Colors.grey,
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Container(
                                    width: 170.0,
                                    height: 180,
                                    //height: 300,
                                    child: ValueListenableBuilder<double>(
                                      valueListenable: tempValue,
                                      builder: (context, value, child) {
                                        return TemperatureGadget(tempValue);
                                      },
                                    ),
                                    //new TemperatureGadget(tempValue.value),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Humidity',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Card(
                                  shadowColor: Colors.grey,
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Container(
                                    width: 170.0,
                                    height: 180,
                                    //height: 300,
                                    child: ValueListenableBuilder<double>(
                                      valueListenable: humidityValue,
                                      builder: (context, value, child) {
                                        return HumidityGadget(humidityValue);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Row(
                  children: [
                    FutureBuilder(
                        future: _deviceRepo.getMoistureData().once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          moistureData.clear();
                          if (snapshot.hasData) {
                            Map<dynamic, dynamic> values = snapshot.data!.value;
                            if (values == null) {
                              MoistureModel data = MoistureModel(0, 0);
                              moistureData.add(data);
                              _toast.showMsg('No moisture data to be shown');
                            } else {
                              values.forEach((key, values) {
                                MoistureModel data =
                                    MoistureModel.fromJson(values);
                                moistureData.add(data);
                                // //print(data);
                              });
                              // SensorsServices.FilterTemperatureAndTriggerNotif(
                              //     moistureData.last.value.toDouble());
                            }
                            //print(moistureData);
                            //print(moistureData.last);
                            return Column(
                              children: [
                                Text('Moisture',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Card(
                                  shadowColor: Colors.grey,
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Container(
                                    width: 170.0,
                                    height: 180,
                                    //height: 300,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.water_drop,
                                          color: Colors.lightBlue,
                                          size: 70,
                                        ),
                                        Text(moistureData.last.value.toInt().toString(),
                                            style: TextStyle(
                                                fontSize: 60,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                    FutureBuilder(
                        future: _deviceRepo.getPhData().once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          phData.clear();
                          if (snapshot.hasData) {
                            Map<dynamic, dynamic> values = snapshot.data!.value;
                            if (values == null) {
                              PhModel data = PhModel(0, 0);
                              phData.add(data);
                              _toast.showMsg('No PH data to be shown');
                            } else {
                              values.forEach((key, values) {
                                PhModel data = PhModel.fromJson(values);
                                phData.add(data);
                                // //print(data);
                              });
                              // SensorsServices.FilterTemperatureAndTriggerNotif(
                              //     moistureData.last.value.toDouble());
                            }
                            phValue.value = phData.last.value.toDouble();
                            //print(phValue.value);
                            //print(phData);
                            //print(phData.last);
                            return Column(
                              children: [
                                Text('Ph',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                Card(
                                  shadowColor: Colors.grey,
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Container(
                                    width: 170.0,
                                    height: 180,
                                    //height: 300,
                                    child: ValueListenableBuilder<double>(
                                      valueListenable: phValue,
                                      builder: (context, value, child) {
                                        return PhGadget(phValue);
                                      },
                                    ),

                                  ),
                                ),
                              ],
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ],
                ),
              ),
              FutureBuilder(
                  future: _deviceRepo.getNpkData().once(),
                  builder:
                      (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        npkData.clear();
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> values = snapshot.data!.value;
                      if (values == null) {
                        NPKModel data = NPKModel(0, 0, 0, 0);
                        npkData.add(data);
                        _toast.showMsg('No NPK data to be shown');
                      } else {
                        values.forEach((key, values) {
                          NPKModel data = NPKModel.fromJson(values);
                          npkData.add(data);
                          //print(data);
                        });
                        // SensorsServices.FilterTemperatureAndTriggerNotif(
                        //     moistureData.last.value.toDouble());
                      }
                      npkValues.value[0] = npkData.last.n.toDouble();
                      npkValues.value[1] = npkData.last.p.toDouble();
                      npkValues.value[2] = npkData.last.k.toDouble();
                      // nValue.value = npkData.last.n.toDouble();
                      // pValue.value = npkData.last.p.toDouble();
                      // kValue.value = npkData.last.k.toDouble();
                      // print(nValue.value);
                      // print(pValue.value);
                      // print(kValue.value);
                      //print(npkData);
                      //print(npkData.last);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8, top: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text('NPK Sensor',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17, fontWeight: FontWeight.bold)),
                                Card(
                                  shadowColor: Colors.grey,
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: SizedBox(
                                        width: 260.0,
                                        height: 180,
                                        //height: 300,
                                        child: ValueListenableBuilder<List<double>>(
                                          valueListenable: npkValues,
                                          builder: (context, value, child) {
                                            return NpkSensor(npkValues);
                                          },
                                        ),

                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator());
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
