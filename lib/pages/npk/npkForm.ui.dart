import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';
import 'package:internet_of_tomato_farming/shared/toasts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../shared/preferencesService.dart';




class NpkForm extends StatefulWidget {
  @override
  _NpkFormState createState() => _NpkFormState();
}

class _NpkFormState extends State<NpkForm> {
  final _formKey = GlobalKey<FormState>();
  final _toast = ToastMsg();
  final preferenceService = PreferencesService();
  DateTime? _date = null;
  final sensorsService = SensorsServices();

  final TextEditingController _area = TextEditingController();
  final TextEditingController _layerDepth = TextEditingController();
  final TextEditingController _volume = TextEditingController();
  final TextEditingController _dryWeightOfSoil = TextEditingController();

  var _datePlant = null;
  var _mass = null;

   @override
  initState() {
     getFromPref();
      // if(_datePlant != null && _mass != null) testNpk();
  }

  void getFromPref() async {
    await preferenceService.getPlantingDate().then((value) => setState(() {_datePlant = value; print('date in state : $_datePlant');}));
    //await preferenceService.getMassSoil().then((value) => setState(() {_mass = value; print('mass in state : $_mass'); } ));
  }
/*
  void testNpk(){
    List<dynamic> results = sensorsService.npkFilter(224, 91, 83, _datePlant, _mass);
    print('results : $results');
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Necessary information'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 10.0,bottom: 10.0),
                child: Column(
                  children: [
                    Text(
                        'Please fill in the form to get personalized recommendations', style: GoogleFonts.ptSerif(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                    SizedBox(height: 10,),
                    Text('To see what each input mean click on the icon on the right', style: GoogleFonts.ptSerif(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(top: 17, bottom: 17),
                      side: BorderSide(width: .6)),
                  // foreground
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                          doneStyle: TextStyle(color: Colors.lightGreen, fontSize: 16),
                        ),
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2040, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            if (date.isBefore(DateTime.now())) {
                              _date = date;
                            } else {
                              _toast.showMsg('');
                            }
                          });
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  label: _date == null
                      ? Text('Enter the date in which you planted you seeds', style: TextStyle(color: Colors.grey[700], fontSize: 15),)
                      : Text(
                    DateFormat('yyyy-MM-dd').format(_date!).toString() + '',
                    style: const TextStyle(color: Colors.lightGreen),
                  ),
                  icon: const Icon(Icons.date_range, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _area,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a numeric value';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      suffixIcon: IconButton(
                        icon: FaIcon(FontAwesomeIcons.chartArea,
                            color: Colors.black),
                        onPressed: () {
                          showAreaDialog('area');
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Area of you garden bed (in square meter)',
                      hintText: 'Area of you garden bed (in square meter)'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: _layerDepth,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a numeric value';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      suffixIcon: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.layerGroup,
                            color: Colors.black),
                        onPressed: () {
                          showAreaDialog('layer');
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Layer depth of you garden bed (in meter)',
                      hintText: 'Layer depth of you garden bed (in meter)'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: _volume,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a numeric value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    suffixIcon: IconButton(
                      icon: FaIcon(FontAwesomeIcons.v,
                          color: Colors.black),
                      onPressed: () {
                        showAreaDialog('volume');
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Volume of you garden bed (in meter cube)',
                    hintText: 'Volume of you garden bed (in meter cube)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  controller: _dryWeightOfSoil,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this field';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a numeric value';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    suffixIcon: IconButton(
                      icon: FaIcon(FontAwesomeIcons.weightHanging,
                          color: Colors.black),
                      onPressed: () {
                        showAreaDialog('weight');
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Dry weight of the soil (in kilograms)',
                    hintText: 'Dry weight of the soil (in kilograms)',
                  ),
                ),
              ),

              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate() && _date != null){
                          double area = double.parse(_area.text);
                          double layerDepth = double.parse(_layerDepth.text);
                          double volume = double.parse(_volume.text);
                          double soilWeight = double.parse(_dryWeightOfSoil.text);

                          double massOfSoilLayer = area * layerDepth * (soilWeight / volume);

                          preferenceService.saveMassSoil(massOfSoilLayer);
                          preferenceService.savePlantingDate(_date!);
                          print ("area  : $area");
                          print ("layerDepth  : $layerDepth");
                          print ("volume  : $volume");
                          print ("soilWeight  : $soilWeight");
                          print ("massOfSoilLayer / 1000000 = " + (massOfSoilLayer / 1000000).toString());
                          print ("Successful  : $massOfSoilLayer");
                        }else{
                          print ("Unsuccessful");
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),

                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _area.dispose();
    _layerDepth.dispose();
    _dryWeightOfSoil.dispose();
    _volume.dispose();
  }


  void showAreaDialog(String whichInput){
    String msg;
    String image;
    if(whichInput == 'area'){
      msg = 'How to calculate the area of your bed garden : ';
      image = 'assets/images/area.png';
    }else if (whichInput == 'layer'){
      msg = 'How to calculate the layer depth of your bed garden : ';
      image = 'assets/images/depth.png';
    }else if (whichInput == 'volume'){
      msg = 'How to calculate the volume of your bed garden : ';
      image = 'assets/images/volume.png';
    }else{
      msg = 'Give us an approximation for the weight of the dry soil you used in your garden bed';
      image = 'assets/images/soil.png';
    }

    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      borderSide: const BorderSide(
        color: Colors.lightGreen,
        width: 2,
      ),
      width: 440,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      onDismissCallback: (type) {
      },
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: whichInput,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(msg, style: GoogleFonts.ptSerif(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Colors.black),
            ),
          ),
          SizedBox(height: 5,),
          Image.asset(image),
        ],
      ),
      desc: 'This Dialog can be dismissed touching outside',
      //showCloseIcon: true,
      //btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}
