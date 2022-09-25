import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';

import '../../repos/deviceRepo.dart';
import '../../services/sensors.services.dart';
import '../../shared/toasts.dart';
import '../home/ui/humidity.ui.dart';
import '../home/ui/ph.ui.dart';
import '../home/ui/temperature.ui.dart';
import '../models/dht11.model.dart';

class SensorTab extends StatefulWidget {

  @override
  State<SensorTab> createState() => _SensorTabState();
}

class _SensorTabState extends State<SensorTab> {
  final _deviceRepo = DeviceRepo();
  final _toast = ToastMsg();

  List<Dht11Model> dht11Data = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: _deviceRepo.getTemperatureAndHumidityData().once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    dht11Data.clear();
                    if(snapshot.hasData) {
                      Map<dynamic, dynamic> values = snapshot.data!.value;
                      if (values == null){
                        Dht11Model data = Dht11Model(0, 0, 0);
                        dht11Data.add(data);
                        _toast.showMsg('No data to be shown');
                      }else {
                        values.forEach((key, values) {
                          Dht11Model data = Dht11Model.fromJson(values);
                          dht11Data.add(data);
                          // print(data);
                        });
                        SensorsServices.FilterTemperatureAndTriggerNotif(dht11Data.last.temperature.toDouble());
                      }
                      print(dht11Data);
                      print(dht11Data.last);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                const Text('Temperature', style: TextStyle(
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
                                    child: TemperatureGadget(double.parse(dht11Data.last.temperature.toString())),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Humidity', style: TextStyle(
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
                                    child: HumidityGadget(double.parse(dht11Data.last.humidity.toString())),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text('Moisture', style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                        Card(
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            width: 170.0,
                            height: 180,
                            //height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Icon(Icons.water_drop, color: Colors.lightBlue, size: 70,),
                                Text('78', style: TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Ph', style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                        Card(
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            width: 170.0,
                            height: 180,
                            //height: 300,
                            child: PhGadget(),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
