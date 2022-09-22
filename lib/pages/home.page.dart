
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/humidity.ui.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/ph.ui.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/temperature.ui.dart';
import 'package:accordion/accordion.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: ListView(
          children: [Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text('Temperature', style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                        Card(
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            width: 170.0,
                            height: 180,
                            //height: 300,
                            child: TemperatureGadget(),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Humidity', style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                        Card(
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            width: 170.0,
                            height: 180,
                            //height: 300,
                            child: const HumidityGadget(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                              children: [
                                Icon(Icons.water_drop, color: Colors.lightBlue, size: 70,),
                                const Text('78', style: TextStyle(
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
        ),
    );
  }
}
