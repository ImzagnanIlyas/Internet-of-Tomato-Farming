import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/pages/home/ui/temperature.ui.dart';
import 'package:internet_of_tomato_farming/repos/productRepo.dart';

class DashboardGadgets extends StatefulWidget {
  const DashboardGadgets({Key? key}) : super(key: key);

  @override
  State<DashboardGadgets> createState() => _DashboardGadgetsState();
}

class _DashboardGadgetsState extends State<DashboardGadgets> {
  ProductRepo _productRepo = ProductRepo();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: StreamBuilder(
          stream: _productRepo.getAggregationDataStream(),
          builder: _streamBuilder
      ),
    );
  }

  Widget _streamBuilder(BuildContext context, AsyncSnapshot<DatabaseEvent> snap){
    Map? data = snap.data?.snapshot.value as Map?;
    var tempAirAvg, tempSoilAvg,humidityAvg,moistureAvg,phAvg,nAvg,pAvg,kAvg;
    if(data != null){
      tempAirAvg = data["tempAirAvg"];
      tempSoilAvg = data["tempSoilAvg"];
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          children: [
            _buildGadgetCard("Air Temperature", tempAirAvg
                , TemperatureGadget(tempAirAvg?.toDouble())),
            _buildGadgetCard("Soil Temperature", tempSoilAvg
                , TemperatureGadget(tempSoilAvg?.toDouble())),
          ],
        ),
      ),
    );
  }

  Widget _buildGadgetCard(String title, var value ,Widget gadget){
    return Column(
      children: [
        Text(title,
            style: GoogleFonts.quicksand(
                fontSize: 17,
                fontWeight: FontWeight.bold)
        ),
        Card(
          shadowColor: Colors.grey,
          color: Colors.white,
          elevation: 5,
          child: Container(
              width: 170.0,
              height: 180,
              child: Visibility(
                  visible: (value != null) ? true : false,
                  replacement: const Center(
                      child: CircularProgressIndicator()
                  ),
                  child: gadget
              )
          ),
        ),
      ],
    );
  }
}
