import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';

class TempAndHumNotifDisplay extends StatefulWidget {
  StatusTemp tempStatus;
  var tempValue;
  var humidityValue;


  TempAndHumNotifDisplay(this.tempStatus, this.tempValue, this.humidityValue);

  @override
  State<TempAndHumNotifDisplay> createState() => _TempAndHumNotifDisplayState(tempStatus, tempValue, humidityValue);
}

class _TempAndHumNotifDisplayState extends State<TempAndHumNotifDisplay> {
  late StatusTemp tempStatus;
  var tempValue;
  var humidityValue;


  _TempAndHumNotifDisplayState(
      this.tempStatus, this.tempValue, this.humidityValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Temperature alert', style: TextStyle(
            //fontSize: 22,
            //fontWeight: FontWeight.bold,
            color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Material(
                        elevation: 89,
                        shadowColor: Colors.grey,
                        //color: Colors.grey[400], // Button color
                        color: Colors.red[400], // B
                        child: InkWell(
                          splashColor: Colors.grey[300], // Splash color
                          onTap: () {},
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Center(
                                child: FaIcon(
                              FontAwesomeIcons.temperatureHigh,
                              color: Colors.white,
                              size: 50,
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tempStatus == StatusTemp.High ? Text('High temperature',
                            style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)) : Text('Low temperature',
                            style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(tempValue.toString() + ' °C',
                            style: GoogleFonts.montserrat(
                                fontSize: 21,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Material(
                        elevation: 89,
                        shadowColor: Colors.grey,
                        //color: Colors.grey[400], // Button color
                        color: Colors.blue[400], // B
                        child: InkWell(
                          splashColor: Colors.grey[300], // Splash color
                          onTap: () {},
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Center(
                                child: FaIcon(
                              FontAwesomeIcons.droplet,
                              color: Colors.white,
                              size: 50,
                            )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tempStatus == StatusTemp.High ? Text('Low humidity',
                            style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)) : Text('High humidity',
                            style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(humidityValue.toString() + ' %',
                            style: GoogleFonts.montserrat(
                                fontSize: 21,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Accordion(
                headerBackgroundColor: Colors.green,
                contentBorderColor: Colors.green,
                maxOpenSections: 2,
                children: [
                  AccordionSection(
                    isOpen: true,
                    header: Text('Consequences',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    content: tempStatus == StatusTemp.High ? Text('Hot temperature and dry winds cause excessive flower drop.', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)):
                  Text('Low temperature and moist weather conditions result in the occurrence and spread of foliar diseases.', style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
                    leftIcon: FaIcon(FontAwesomeIcons.triangleExclamation,
                        color: Colors.white),
                  ),
                  AccordionSection(
                    isOpen: true,
                    header: Text('Ideal Climate',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    content: Text(
                        'A tomato crop requires very stable temperature. The minimum temperature is around 10°C with the maximum being 34°C. Optimum temperatures are around 26 - 29°C. Temperature variation might result in poor fruit quality or reduced yields. ', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                    leftIcon: FaIcon(FontAwesomeIcons.temperatureHigh,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
