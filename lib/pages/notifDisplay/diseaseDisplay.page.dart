import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';

import '../models/disease.model.dart';
import '../tabs/plantStatus.page.dart';

class DiseaseDisplay extends StatefulWidget {
  final DateTime diseaseTime;
  DiseaseDisplay({Key? key, required this.diseaseTime}) : super(key: key);

  @override
  State<DiseaseDisplay> createState() => _DiseaseDisplayState();
}

class _DiseaseDisplayState extends State<DiseaseDisplay> {
  final _deviceRepo = DeviceRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease Alert"),
        backgroundColor: Colors.lightGreen,
      ),
      body: FutureBuilder(
        future: _deviceRepo.getDiseaseDataByTime(widget.diseaseTime).once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
          if(snapshot.hasData){
            Map<dynamic, dynamic> values = snapshot.data!.value;
            DiseaseModel? data;
            if(values != null){
              values.forEach((key, values) {
                data = DiseaseModel.fromJson(values);
              });
            }
            return SingleChildScrollView(child: PlantStatusTab(NotificationDisease: data));
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // body: PlantStatusTab(NotificationDisease: widget.disease)
    );
  }
}
