
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/humidity.ui.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/ph.ui.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/temperature.ui.dart';
import 'package:internet_of_tomato_farming/pages/models/dht11.model.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';

import '../shared/toasts.dart';



class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _deviceRepo = DeviceRepo();
  final _toast = ToastMsg();

  List<Dht11Model> dht11Data = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: ListView(
            children: [Column(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      width: 400,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 100,
                              child: ClipOval(
                                child: Image.network(
                                  'https://www.thespruce.com/thmb/iGx8FNUqlKjnl3OQFHxS0rebj5o=/941x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/top-tomato-growing-tips-1402587-11-c6d6161716fd448fbca41715bbffb1d9.jpg',
                                  width: 190,
                                  height: 190,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Card(
                              shadowColor: Colors.grey,
                              color: Colors.green,
                              elevation: 5,
                            child:  Container(
                              height: 100,
                              width: 100,
                              child: Text('Healthy', style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),]
          )
    );
  }
}
