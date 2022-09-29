import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PhNotifDisplay extends StatefulWidget {
  @override
  State<PhNotifDisplay> createState() => _PhNotifDisplayState();
}

class _PhNotifDisplayState extends State<PhNotifDisplay> {
  double width = 0.4;
  double valuePh = 11.5;
  late StatusPh phStatus = StatusPh.Acidic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 12),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                          gradient: phStatus == StatusPh.Acidic ? LinearGradient(
                              colors: [Colors.deepOrangeAccent, Colors.yellowAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight) :
                          LinearGradient(
                              colors: [Colors.lightBlueAccent, Colors.deepPurple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                  child: Center(
                    child: phStatus == StatusPh.Acidic ? Text('The soil is acidic',
                        style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)) :
                    Text('The soil is alkaline',
                        style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  )
                ),
                Container(
                  width: 180,
                  height: 180,
                  child: phStatus == StatusPh.Acidic ? SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 6,
                        showLabels: false,
                        axisLineStyle: AxisLineStyle(
                            thicknessUnit: GaugeSizeUnit.factor,
                            thickness: 0.1,
                            cornerStyle: CornerStyle.bothCurve),
                        startAngle: 115,
                        endAngle: 65,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 1,
                              color: Color(0xFFed1c24),
                              label: '0',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFed1c24),
                                Color(0xFFf96e3b)
                              ], stops: <double>[
                                0.1,
                                1
                              ]),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width,
                              endWidth: width),
                          GaugeRange(
                              startValue: 1,
                              endValue: 2,
                              color: Color(0xFFf96e3b),
                              label: '1',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFf96e3b),
                                Color(0xFFf7b517)
                              ], stops: <double>[
                                0.1,
                                1
                              ]),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width,
                              endWidth: width),
                          GaugeRange(
                              startValue: 2,
                              endValue: 3,
                              color: Color(0xFFf7b517),
                              label: '2',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFf7b517),
                                Color(0xFFfff735)
                              ], stops: <double>[
                                0.1,
                                1
                              ]),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width,
                              endWidth: width),
                          GaugeRange(
                              startValue: 3,
                              endValue: 4,
                              color: Color(0xFFfff735),
                              label: '3',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFfff735),
                                Color(0xFFcae801)
                              ], stops: <double>[
                                0.1,
                                1
                              ]),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width,
                              endWidth: width),
                          GaugeRange(
                              startValue: 4,
                              endValue: 5,
                              color: Color(0xFFcae801),
                              label: '4',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFcae801),
                                Color(0xFF8ed404)
                              ], stops: <double>[
                                0.1,
                                1
                              ]),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width,
                              endWidth: width),
                          GaugeRange(
                              startValue: 5,
                              endValue: 6,
                              color: Color(0xFF8ed404),
                              label: '5',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFF8ed404),
                                Color(0xFF4cbf04)
                              ], stops: <double>[
                                0.1,
                                1
                              ]),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width,
                              endWidth: width),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                              value: valuePh,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.7,
                              needleStartWidth: 0.5,
                              needleEndWidth: 4,
                              knobStyle: KnobStyle(
                                  knobRadius: 0.1,
                                  sizeUnit: GaugeSizeUnit.factor)),
                        ],
                        annotations: <GaugeAnnotation>[],
                      ),
                    ],
                  ) : SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 8,
                        maximum: 15,
                        showLabels: false,
                        axisLineStyle: AxisLineStyle(
                            thicknessUnit: GaugeSizeUnit.factor,
                            thickness: 0.1,
                            cornerStyle: CornerStyle.bothCurve
                        ),
                        startAngle: 115,
                        endAngle: 65,
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 8, endValue: 9,
                              color: Color(0xFF01b974), label: '8',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(
                                  colors: <Color>[Color(0xFF01b974), Color(0xFF00c9c9)],
                                  stops: <double>[0.1, 1]
                              ),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                          GaugeRange(startValue: 9, endValue: 10,
                              color: Color(0xFF00c9c9), label: '9',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(
                                  colors: <Color>[Color(0xFF00c9c9), Color(0xFF039cdb)],
                                  stops: <double>[0.1, 1]
                              ),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                          GaugeRange(startValue: 10, endValue: 11,
                              color: Color(0xFF039cdb), label: '10',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(
                                  colors: <Color>[Color(0xFF039cdb), Color(0xFF006be7)],
                                  stops: <double>[0.1, 1]
                              ),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                          GaugeRange(startValue: 11, endValue: 12,
                              color: Color(0xFF006be7), label: '11',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(
                                  colors: <Color>[Color(0xFF006be7), Color(0xFF3a5cde)],
                                  stops: <double>[0.1, 1]
                              ),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                          GaugeRange(startValue: 12, endValue: 13,
                              color: Color(0xFF3a5cde), label: '12',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(
                                  colors: <Color>[Color(0xFF3a5cde), Color(0xFF6a4bd5)],
                                  stops: <double>[0.1, 1]
                              ),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                          GaugeRange(startValue: 13, endValue: 14,
                              color: Color(0xFF6a4bd5), label: '13',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              gradient: const SweepGradient(
                                  colors: <Color>[Color(0xFF6a4bd5), Color(0xFF5b3ab0)],
                                  stops: <double>[0.1, 1]
                              ),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                          GaugeRange(startValue: 14, endValue: 15,
                              color: Color(0xFF5b3ab0), label: '14',
                              labelStyle: GaugeTextStyle(color: Colors.white),
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: width, endWidth: width),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                              value: valuePh,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleLength: 0.7,
                              needleStartWidth: 0.5, needleEndWidth: 4,
                              knobStyle: KnobStyle(
                                  knobRadius: 0.1,
                                  sizeUnit: GaugeSizeUnit.factor
                              )
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                        ],
                      ),
                    ],
                  ),
                ),
                Accordion(
                  headerBackgroundColor: Colors.green,
                  contentBorderColor: Colors.green,
                  maxOpenSections: 3,
                  children: [
                    AccordionSection(
                      isOpen: true,
                      header: Text('Consequences',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: phStatus == StatusPh.Acidic ? Text('If the soil is too acidic, that will generally slow the growth of tomato plants and ultimately reduce harvest. It also leads to nutrient deficiencies, resulting in a problem like an end rot on tomato fruit.', style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)) :
                      Text('Where the soil is too alkaline, would greatly affect the growth and yield of the tomatoes plant.', style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                      leftIcon: FaIcon(FontAwesomeIcons.triangleExclamation,
                          color: Colors.white),
                    ),
                    AccordionSection(
                      isOpen: true,
                      header: Text('More Infos',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: Text(
                          ' The soil should be rich in organic matter and plant nutrients, with a pH value of 6 to 7.', style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                      leftIcon: Icon(Icons.info, color: Colors.white),
                    ),
                    phStatus == StatusPh.Acidic ? AccordionSection(
                      isOpen: true,
                      header: Text('Suggestions',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: Column(
                        children: [
                          Text(
                              'You may need to increase the pH level. The following are a few ways to achieve this :', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                          SizedBox(height: 5),
                          Text(
                              'Addition of Compost : ', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              ' If you add compost to your soil, it will not only feed your soil with very valuable nutrients, it will also help stabilize the pH level. Where the pH is too high, it helps lower it, and when it is too low, it helps increase it.', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black, )),
                          SizedBox(height: 8),
                          Text(
                              'Limestone (calcium) :', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              'This is one of the most common ways to lower the soil’s pH levels. By adding limestone to the soil, calcium bicarbonate is formed which helps to improve the soil’s pH levels.', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black, )),
                          SizedBox(height: 8),
                          Text(
                              'Wood Ashes : ', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              'This is one of the natural ways to amend the acidic nature of soil as they contain calcium carbonate. Where you have a fireplace, spreading some ashes from the fireplace on the soil may be of great assistance here.', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black, )),
                          SizedBox(height: 8),
                          Text(
                              'Removal of Pine Needles : ', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              'Recent research has shown that pine needles do not substantially affect soil pH levels. However, freshly dropped pine needles have been discovered tobe a very good neutralizer of soil pH.', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black, )),
                          SizedBox(height: 8),

                        ],
                      ),
                      leftIcon: FaIcon(FontAwesomeIcons.fileCirclePlus,
                          color: Colors.white),
                    ) : AccordionSection(
                      isOpen: true,
                      header: Text('Suggestions',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      content: Column(
                        children: [
                          Text(
                              'You may need to lower this level. The following are a few ways to achieve this : ', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                          SizedBox(height: 5),
                          Text(
                              'Use of Compost : ', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              'If you add compost to your soil, it will not only feed your soil with very valuable nutrients, it will also help stabilize the pH level. Where the pH is too high, it helps lower it, and when it is too low, it helps increase it. So, it’s both manure and pH balancer.', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black, )),
                          SizedBox(height: 8),
                          Text(
                              'Sulfur :', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              'The use of sulfur is another way to balance the soil’s pH levels. The use of sulfur just like compost helps to balance the soil’s pH levels. You should however be careful not to add too much sulfur to the soil as this may be harmful to plants.', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black, )),
                          SizedBox(height: 8),
                          Text(
                              'Sphagnum Peat Moss : ', style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Text(
                              'This is a slow-acting agent for the amendment of the soil’s organic content and pH levels. It is also a good substance to help improve water retention and aeration in your soil', style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black, )),

                        ],
                      ),
                      leftIcon: FaIcon(FontAwesomeIcons.fileCirclePlus,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            )));
  }
}
