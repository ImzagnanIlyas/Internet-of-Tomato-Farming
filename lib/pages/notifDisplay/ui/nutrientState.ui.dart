import 'package:accordion/accordion.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';

class NutrientState extends StatefulWidget {
  StatusNpk symbole;

  ConditionNpk status;
  var value;

  NutrientState(this.symbole, this.status, this.value);

  @override
  State<NutrientState> createState() =>
      _NutrientStateState(symbole, status, value);
}

class _NutrientStateState extends State<NutrientState> {
  late StatusNpk symbole;
  late ConditionNpk status;
  var value;
  var icon;

  _NutrientStateState(this.symbole, this.status, this.value);

  var msg;
  Color? color;
  var nutrient;

  // var consequenceForHighN = '';
  var consequenceForLowN = 'Under nitrogen deficiency, the leaves gradually change from their normal characteristic green appearance to a much paler green. As the deficiency progresses these leaves become uniformly yellow.';
  // var moreInformationForHighN = '';
  var moreInformationForLowN = 'The plants need a high requirement of nitrogen, especially in this stage. Nitrogen promotes better growth and better flower and fruit set. At this stage, a level of (95/150/220) kg per hectare of nitrogen is recommended.';
  // var suggestionForHighN = '';
  var suggestionForLowN = 'Good organic fertilizer sources of nitrogen: \n 1. alfalfa meal \n 2. blood meal  \n 3. compost \n 4. feather meal \n 5. fish meal \n 6. legumes \n 7. leaf mold \n 8. Soy bean meal';

  // var consequenceForHighK = '';
  var consequenceForLowP = 'Phosphorus deficiency symptoms are not very distinct and thus difficult to identify. A major visual symptom is that the plants are dwarfed or stunted.';
  // var moreInformationForHighK = '';
  var moreInformationForLowP = 'Phosphorus promotes root development, early flowering and fruit set and ensures more vigorous growth. For this stage, a total of (68/80/98) kg of phosphorus per hectare is suggested in soils with a built-up of the nutrient.';
  // var suggestionForHighK = '';
  var suggestionForLowP = 'Good organic fertilizer sources of phosphorus: \n 1. bone meal \n 2. compost \n 3. Rock phosphate';

  // var consequenceForHighP = '';
  var consequenceForLowK = 'The onset of potassium deficiency is generally characterized by a marginal chlorosis, progressing into a dry leathery tan scorch on recently matured leaves. As the deficiency progresses, most of the interveinal area becomes necrotic, the veins remain green and the leaves tend to curl and crinkle. Typical potassium deficiency of fruit is characterized by color development disorders, including greenback, blotch ripening and boxy fruit.';
  // var moreInformationForHighP = '';
  var moreInformationForLowK = 'Tomato requires high levels of potassium. Adequate levels of potassium result in improved color, taste, firmness, sugars, acids and solids of the fruit. Plant cells are also strengthened. At this stage, a total of (130/240/360) kg of potassium should be applied per hectare. ';
  // var suggestionForHighP = '';
  var suggestionForLowK = 'Good organic fertilizer sources of potassium: \n 1. wood ash  \n 2. granite dust (also called rock potash)';



  var consequenceMsg = '';
  var moreInformationMsg = '';
  var suggestionMsg = '';

  @override
  void initState() {
    if (symbole == StatusNpk.N) {
      nutrient = 'Nitrogen';
      icon = FontAwesomeIcons.n;
    }
    if (symbole == StatusNpk.P) {
      nutrient = 'Potassium';
      icon = FontAwesomeIcons.p;
    }
    if (symbole == StatusNpk.K) {
      nutrient = 'Phosphorus';
      icon = FontAwesomeIcons.k;
    }

    if (status != ConditionNpk.Good) {
      if (status == ConditionNpk.Low) {
        msg = 'Low level of ' + nutrient;
        if (symbole == StatusNpk.N) {consequenceMsg = consequenceForLowN; moreInformationMsg = moreInformationForLowN; suggestionMsg = suggestionForLowN;}
        if (symbole == StatusNpk.P) {consequenceMsg = consequenceForLowP; moreInformationMsg = moreInformationForLowP; suggestionMsg = suggestionForLowP;}
        if (symbole == StatusNpk.K) {consequenceMsg = consequenceForLowK; moreInformationMsg = moreInformationForLowK; suggestionMsg = suggestionForLowK;}
      }
      // if (status == ConditionNpk.High) {
      //   msg = 'High level of ' + nutrient;
      //   if (symbole == StatusNpk.N) {consequenceMsg = consequenceForHighN; moreInformationMsg = moreInformationForHighN; suggestionMsg = suggestionForHighN;}
      //   if (symbole == StatusNpk.P) {consequenceMsg = consequenceForHighP; moreInformationMsg = moreInformationForHighP; suggestionMsg = suggestionForHighP;}
      //   if (symbole == StatusNpk.K) {consequenceMsg = consequenceForHighK; moreInformationMsg = moreInformationForHighK; suggestionMsg = suggestionForHighK;}
      // }

      color = Colors.red;
    } else {
      color = Colors.green;
      msg = 'Good level of ' + nutrient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Material(
                color: color, // Button color
                child: InkWell(
                  //splashColor: Colors.redAccent, // Splash color
                  onTap: () {},
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                        child: FaIcon(
                      icon,
                      color: Colors.white,
                      size: 25,
                    )),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Text(msg + ' : ',
                style: GoogleFonts.ptSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                )),
            SizedBox(
              height: 5,
            ),
            Text(value.toString() + ' kg/ha',
                style: GoogleFonts.ptSans(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        if (status != ConditionNpk.Good)
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                callDialog();
              },
              child: Text(
                'See what you can do',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
      ],
    );
  }

  void callDialog() {
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
      onDismissCallback: (type) {},
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: '',
      body: messages(),
      desc: 'This Dialog can be dismissed touching outside',
      //showCloseIcon: true,
      //btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  Widget messages() {
    return Accordion(
      headerBackgroundColor: Colors.green,
      contentBorderColor: Colors.green,
      maxOpenSections: 1,
      children: [
        AccordionSection(
          isOpen: true,
          header: Text('Consequences',
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          content: Text(
              consequenceMsg,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
          leftIcon: const FaIcon(FontAwesomeIcons.triangleExclamation,
              color: Colors.white),
        ),
        AccordionSection(
          isOpen: true,
          header: Text('More Infos',
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          content: Text(moreInformationMsg,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
          leftIcon: Icon(Icons.info, color: Colors.white),
        ),
        AccordionSection(
          isOpen: true,
          header: Text('Suggestions',
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          content: Text(suggestionMsg,
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
          leftIcon: Icon(Icons.info, color: Colors.white),
        ),
      ],
    );
  }
}
