import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/pages/notifDisplay/ui/nutrientState.ui.dart';

import '../../services/sensors.services.dart';
import '../home/ui/NpkSensor.ui.dart';

class NpkNotifDisplay extends StatefulWidget {
  ConditionNpk nitrogenCondition;
  ConditionNpk phosphorusCondition;
  ConditionNpk potassiumCondition;
  int nitrogenValue;
  int phosphorusValue;
  int potassiumValue;
  PlantGrowthStage plantGrowthStage;


  NpkNotifDisplay(
      this.nitrogenCondition,
      this.phosphorusCondition,
      this.potassiumCondition,
      this.nitrogenValue,
      this.phosphorusValue,
      this.potassiumValue,
      this.plantGrowthStage);

  @override
  State<NpkNotifDisplay> createState() => _NpkNotifDisplayState(
      nitrogenCondition,
      phosphorusCondition,
      potassiumCondition,
      nitrogenValue,
      phosphorusValue,
      potassiumValue,
      plantGrowthStage);
}

class _NpkNotifDisplayState extends State<NpkNotifDisplay> {
  ConditionNpk nitrogenCondition;
  ConditionNpk phosphorusCondition;
  ConditionNpk potassiumCondition;
  int nitrogenValue;
  int phosphorusValue;
  int potassiumValue;
  PlantGrowthStage plantGrowthStage;

  _NpkNotifDisplayState(
      this.nitrogenCondition,
      this.phosphorusCondition,
      this.potassiumCondition,
      this.nitrogenValue,
      this.phosphorusValue,
      this.potassiumValue,
      this.plantGrowthStage);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, top: 4, right: 10),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Center(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                              colors: [Colors.lightGreen, Colors.green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: Center(
                        child: Text('Plant growth stage : '+ plantGrowthStage.name,
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Center(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                              colors: [Colors.lightGreen, Colors.green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: Center(
                        child: Text('Nutrients status',
                            style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              shadowColor: Colors.grey,
              color: Colors.grey[100],
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                          //height: 300,
                          child: NutrientState(
                              StatusNpk.N, nitrogenCondition, nitrogenValue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: SizedBox(
                          //height: 300,
                          child: NutrientState(
                              StatusNpk.P, phosphorusCondition, phosphorusValue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: SizedBox(
                          //height: 300,
                          child: NutrientState(
                              StatusNpk.K, potassiumCondition, potassiumValue)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Center(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                              colors: [Colors.lightGreen, Colors.green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: Center(
                        child: Text('Ideal nutrient values',
                            style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Card(
                  shadowColor: Colors.grey,
                  color: Colors.grey[100],
                  elevation: 5,
                child: Image.asset('assets/images/NPK.jpg'),
              ),


              // child: Card(
              //   shadowColor: Colors.grey,
              //   color: Colors.grey[100],
              //   elevation: 5,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             ClipOval(
              //               child: Material(
              //                 color: Colors.redAccent, // Button color
              //                 child: InkWell(
              //                   //splashColor: Colors.redAccent, // Splash color
              //                   onTap: () {},
              //                   child: SizedBox(
              //                     width: 40,
              //                     height: 40,
              //                     child: Center(
              //                         child: FaIcon(
              //                       FontAwesomeIcons.n,
              //                       color: Colors.white,
              //                       size: 25,
              //                     )),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 14,
              //             ),
              //             Text('Nitrogen : ',
              //                 style: GoogleFonts.ptSans(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.normal,
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text('59' + ' mg/Kg',
              //                 style: GoogleFonts.ptSans(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           //mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             ClipOval(
              //               child: Material(
              //                 color: Colors.blueAccent, // Button color
              //                 child: InkWell(
              //                   //splashColor: Colors.redAccent, // Splash color
              //                   onTap: () {},
              //                   child: SizedBox(
              //                     width: 40,
              //                     height: 40,
              //                     child: Center(
              //                         child: FaIcon(
              //                       FontAwesomeIcons.p,
              //                       color: Colors.white,
              //                       size: 25,
              //                     )),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 14,
              //             ),
              //             Text('Phosphorous : ',
              //                 style: GoogleFonts.ptSans(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.normal,
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text('59' + ' mg/Kg',
              //                 style: GoogleFonts.ptSans(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           //mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             ClipOval(
              //               child: Material(
              //                 color: Colors.purpleAccent, // Button color
              //                 child: InkWell(
              //                   //splashColor: Colors.redAccent, // Splash color
              //                   onTap: () {},
              //                   child: SizedBox(
              //                     width: 40,
              //                     height: 40,
              //                     child: Center(
              //                         child: FaIcon(
              //                       FontAwesomeIcons.k,
              //                       color: Colors.white,
              //                       size: 25,
              //                     )),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 14,
              //             ),
              //             Text('Potassium : ',
              //                 style: GoogleFonts.ptSans(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.normal,
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Text('59' + ' mg/Kg',
              //                 style: GoogleFonts.ptSans(
              //                   fontSize: 15,
              //                   fontWeight: FontWeight.bold,
              //                 )),
              //             SizedBox(
              //               height: 5,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
