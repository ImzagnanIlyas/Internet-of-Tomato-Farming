import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/temperature.ui.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Container(child: TemperatureGadget()),
    );
  }
}
