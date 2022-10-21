import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/pages/models/disease.model.dart';

import '../../repos/deviceRepo.dart';
import '../../shared/toasts.dart';


class PlantStatusTab extends StatefulWidget {

  PlantStatusTab();

  @override
  State<PlantStatusTab> createState() => _PlantStatusTabState();
}

class _PlantStatusTabState extends State<PlantStatusTab> {

  final _deviceRepo = DeviceRepo();
  var status = '';
  var cause = '';
  var symptoms = '';
  var control = '';
  bool isHealthy = true;

  List<DiseaseModel> diseaseData = [];
  final _toast = ToastMsg();



  _PlantStatusTabState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _deviceRepo.getDiseaseData().once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          diseaseData.clear();
          if (snapshot.hasData) {
            Map<dynamic, dynamic> values = snapshot.data!.value;
            if (values == null) {
              DiseaseModel data = DiseaseModel('', '', 0);
              diseaseData.add(data);
              _toast.showMsg(
                  'No disease data to be shown');
            } else {
              values.forEach((key, values) {
                DiseaseModel data = DiseaseModel.fromJson(values);
                diseaseData.add(data);
                // print(data);
              });
            }
            isHealthy = isItHealthy(diseaseData.last.state);
            print(diseaseData);
            print(diseaseData.last);
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(
                children: [
                 Align(alignment:Alignment.bottomCenter,child: CircleAvatar(
                    backgroundColor: isHealthy ? Colors.lightGreen : Colors.red,
                    radius: 160,
                    child: ClipOval(
                      // child: Image.asset(
                      //   'assets/images/sickPlant.jpg',
                      //   width: 310,
                      //   height: 310,
                      //   fit: BoxFit.fill,
                      // ),
                      child: Image.network(
                          diseaseData.last.image,
                          width: 310,
                          height: 310,
                          fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ),
                  Center(
                    child: Padding(
                      padding: isHealthy ? const EdgeInsets.only(top: 230, left: 200) : const EdgeInsets.only(top: 230, left: 10),
                      child: ElevatedButton(
                        child:  Row(
                          children: [
                            Text('Status : ', style: GoogleFonts.montserrat(
                                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          Text(
                            this.status, style: GoogleFonts.montserrat(
                                       fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),),
                          ],
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom( // returns ButtonStyle
                          primary: isHealthy ? Colors.lightGreen : Colors.red,
                          onPrimary: Colors.white,
                          fixedSize: Size(700, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
              isHealthy == false ? Container(
                child: Accordion(
                  headerBackgroundColor: Colors.green,
                  contentBorderColor: Colors.green,
                  maxOpenSections: 2,
                  children: [
                    AccordionSection(
                      isOpen: true,
                      header: Text('Cause',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: Text(cause, style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                      leftIcon: FaIcon(FontAwesomeIcons.triangleExclamation,
                          color: Colors.white),
                    ),
                    AccordionSection(
                      isOpen: true,
                      header: Text('Symptoms',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: Text(
                          symptoms, style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                      leftIcon: FaIcon(FontAwesomeIcons.temperatureHigh,
                          color: Colors.white),
                    ),
                    // AccordionSection(
                    //   isOpen: true,
                    //   header: Text('Conditions for disease development',
                    //       style: GoogleFonts.montserrat(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.white)),
                    //   content: Text(
                    //       'Passalora fulva is an efficient saprophyte and can survive as conidia and sclerotia in soil and plant debris for at least one year. Conidia are readily dispersed by wind and rain. Dissemination can also occur on workers’ clothing and equipment. High (90%) relative humidity and moderate (24°C) temperatures are optimal for disease development; however, disease can occur between 10 and 32°C. Leaf mold will not develop if relative humidity is less than 85%..', style: GoogleFonts.montserrat(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.normal,
                    //       color: Colors.black)),
                    //   leftIcon: FaIcon(FontAwesomeIcons.temperatureHigh,
                    //       color: Colors.white),
                    // ),
                    AccordionSection(
                      isOpen: true,
                      header: Text('Control',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: Text(
                          control, style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                      leftIcon: FaIcon(FontAwesomeIcons.temperatureHigh,
                          color: Colors.white),
                    ),
                  ],
                ),
              ) : Container(),
            ],
          ),
        );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  bool isItHealthy(String status){
    if (status == 'Bacterial_spot'){
      this.status = 'Bacterial spot';
      cause = 'XOXOX';
      symptoms = 'XPXPX';
      control = 'xXPXOX';
      return false;
    }
    if (status == 'Early_blight'){
      this.status = 'Early blight';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Late_blight'){
      this.status = 'Late blight';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Leaf_Mold'){
      this.status = 'Leaf Mold';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Septoria_leaf_spot'){
      this.status = 'Septoria leaf spot';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Spider_mites Two-spotted_spider_mite'){
      this.status = 'Spider mites';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Target_Spot'){
      this.status = 'Target spot';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Tomato_Yellow_Leaf_Curl_Virus'){
      this.status = 'Tomato yellow leaf curl virus';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
    if (status == 'Tomato_mosaic_virus'){
      this.status = 'Tomato mosaic virus';
      cause = '';
      symptoms = '';
      control = '';
      return false;
    }
        this.status = 'Healthy';
        return true;

  }

}
