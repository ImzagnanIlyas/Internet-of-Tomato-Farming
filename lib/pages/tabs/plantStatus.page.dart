import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PlantStatusTab extends StatefulWidget {

  @override
  State<PlantStatusTab> createState() => _PlantStatusTabState();
}

class _PlantStatusTabState extends State<PlantStatusTab> {

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Stack(
            children: [
             Align(alignment:Alignment.bottomCenter,child: CircleAvatar(
                backgroundColor: Colors.lightGreen,
                radius: 160,
                child: ClipOval(
                  child: Image.network(
                    'https://greenfarmer.ma/wp-content/uploads/2022/03/white-blooming-strawberry-flowers-with-green-leaves-grow-on-bed-in-garden-in-sunny-summer-day-organic-farm-vitamins-scaled.jpg',
                    width: 310,
                    height: 310,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 230, left: 190),
                  child: ElevatedButton(
                    child:  Row(
                      children: [
                        Text('Status : ', style: GoogleFonts.montserrat(
                             fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                      Text('Healthy', style: GoogleFonts.montserrat(
                                   fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),),
                      ],
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom( // returns ButtonStyle
                      primary: Random().nextBool() == true ? Colors.lightGreen : Colors.red,
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Details : ', style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(
                  height: 5,
                ),
                Text('Oh I don’t know I never even knew her name but I will say this: the nature of them vocal intonations and the play of feelin upon her face helped me to gather that people are like ferrets.', style : GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),),
              ],
            ),
          )
        ],
      ),
    );
  }

}
