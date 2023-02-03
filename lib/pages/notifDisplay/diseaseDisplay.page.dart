import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';

import '../models/disease.model.dart';
import '../tabs/plantStatus.page.dart';

class DiseaseDisplay extends StatefulWidget {
  DiseaseModel data;
  DiseaseDisplay({Key? key, required this.data}) : super(key: key);

  @override
  State<DiseaseDisplay> createState() => _DiseaseDisplayState();
}

class _DiseaseDisplayState extends State<DiseaseDisplay> {
  final _deviceRepo = DeviceRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease check"),
      ),
      body: SingleChildScrollView(child: PlantStatusTab(data: widget.data))
    );
  }
}
