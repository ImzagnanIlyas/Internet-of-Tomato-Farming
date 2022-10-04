import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';

class MoistureNotifDisplay extends StatefulWidget {
  MoistureStatus moistureStatus;
  var moistureValue;


  MoistureNotifDisplay(this.moistureStatus, this.moistureValue);

  @override
  State<MoistureNotifDisplay> createState() => _MoistureNotifDisplayState(moistureStatus, moistureValue);
}

class _MoistureNotifDisplayState extends State<MoistureNotifDisplay> {
  MoistureStatus moistureStatus;
  var moistureValue;


  _MoistureNotifDisplayState(
      this.moistureStatus, this.moistureValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Moisture alert', style: TextStyle(
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
                        color: Colors.white, // B
                        child: InkWell(
                          splashColor: Colors.grey[300], // Splash color
                          onTap: () {},
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Center(
                                child: Icon(
                                  Icons.water_drop,
                                  color: Colors.lightBlue,
                                  size: 70,
                                ),),
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
                        moistureStatus == MoistureStatus.Moisturized ? Text('The soil is over moisturized',
                            style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)) : Text('The soil is too dry.',
                            style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(moistureValue.toString() + ' %',
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
                    content: moistureStatus == MoistureStatus.Moisturized ? Text(' When tomatoes experience moisture stress, fewer flowers develop per truss, lower numbers of fruit are set and the fruit size decreases.', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)):
                  Text('When tomatoes get too much water, their leaves turn yellow. After that, the fruit develops cracks and blossom end rot rot. Overwatered tomatoes often have a watery flavor and mushy texture. The roots could even start to rot and kill off the entire plant.', style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
                    leftIcon: FaIcon(FontAwesomeIcons.triangleExclamation,
                        color: Colors.white),
                  ),
                  AccordionSection(
                    isOpen: true,
                    header: Text('More info',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    content: moistureStatus == MoistureStatus.Moisturized ? Text('The soil moisture plays role in the process of transferring nutrients and other compounds from the soil medium to plants, maintaining plant temperature and optimizing the maturity of leaves and fruits. Tomato plants must have optimal soil moisture between 60% -80% so that the soil is not too dry or wet.', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)):
                    Text('The soil moisture plays role in the process of transferring nutrients and other compounds from the soil medium to plants, maintaining plant temperature and optimizing the maturity of leaves and fruits. Tomato plants must have optimal soil moisture between 60% -80% so that the soil is not too dry or wet.', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                    leftIcon: FaIcon(FontAwesomeIcons.temperatureHigh,
                        color: Colors.white),
                  ),
                  AccordionSection(
                    isOpen: true,
                    header: Text('Suggestions',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    content: moistureStatus == MoistureStatus.Moisturized ? Text('To dry your soil, you can use these suggested methods: \n 1. Stop Watering and Allow Time To Pass. \n 2. Place Plants in the Windy Area. \n 3. Place Plants in an Area With Low Humidity. \n 4. Ensure There Are Drainage Holes At The Bottom of Your Plant. \n 5. Use a Hairdryer to Dry the Soil.', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)):
                    Text('Add more Water to your soil ( ;', style: GoogleFonts.montserrat(
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
