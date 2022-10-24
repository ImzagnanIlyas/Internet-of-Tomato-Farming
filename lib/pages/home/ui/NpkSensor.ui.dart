import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// class NpkSensor extends StatefulWidget {
//   var n_value;
//   var p_value;
//   var k_value;
//
//   NpkSensor(this.n_value, this.p_value, this.k_value);
//
//   @override
//   State<NpkSensor> createState() => _NpkSensorState(n_value, p_value, k_value);
// }

class NpkSensor extends StatelessWidget {
  final ValueListenable<List<double>> npkValues;

  // final ValueListenable<double> n_value;
  // final ValueListenable<double> p_value;
  // final ValueListenable<double> k_value;



  NpkSensor(this.npkValues);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.red, // Button color
                  child: InkWell(
                    splashColor: Colors.redAccent, // Splash color
                    onTap: () {},
                    child: SizedBox(width: 45, height: 45, child: Center(child: FaIcon(FontAwesomeIcons.n, color: Colors.white, size: 20,)),),
                  ),
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('nitrogen : ',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(npkValues.value[0].toString()+ ' mg/Kg',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,)),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.blue, // Button color
                  child: InkWell(
                    splashColor: Colors.blueAccent, // Splash color
                    onTap: () {},
                    child: SizedBox(width: 45, height: 45, child: Center(child: FaIcon(FontAwesomeIcons.p, color: Colors.white, size: 20,)),),
                  ),
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('phosphorus : ',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(npkValues.value[1].toString()+ ' mg/Kg',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,)),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              ClipOval(
                child: Material(
                  color: Colors.purple, // Button color
                  child: InkWell(
                    splashColor: Colors.purpleAccent, // Splash color
                    onTap: () {},
                    child: SizedBox(width: 45, height: 45, child: Center(child: FaIcon(FontAwesomeIcons.k, color: Colors.white, size: 20,)),),
                  ),
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('potasssium : ',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(npkValues.value[2].toString()+ ' mg/Kg',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,)),
                ],
              )
            ],
          ),
        ),

      ],
    );
  }
}
