import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_of_tomato_farming/pages/models/disease.model.dart';
import 'package:internet_of_tomato_farming/services/sensors.services.dart';

import '../../repos/deviceRepo.dart';
import '../../shared/toasts.dart';


class PlantStatusTab extends StatefulWidget {
  DiseaseModel? NotificationDisease;
  PlantStatusTab({this.NotificationDisease});

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
            if(widget.NotificationDisease != null){
              diseaseData.add(widget.NotificationDisease as DiseaseModel);
            }else if (values == null) {
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
                      padding: isHealthy ? const EdgeInsets.only(top: 230, left: 150) : const EdgeInsets.only(top: 230, left: 10),
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
      cause = 'Bacterial spot is a common disease of tomato plants. It is caused by the bacterium Xanthomonas campestris pv. vesicatoria. The bacterium is spread by splashing water, and can be carried on the hands of gardeners. The bacterium can also be spread by insects, such as aphids, that feed on the leaves of infected plants. The bacterium can survive in the soil for several years.';
      symptoms = 'The first symptoms of bacterial spot are small, dark, water-soaked circular spots less than 3 millimeters in diameter. These spots enlarge and turn brown. The spots may coalesce to form large, irregularly shaped areas of dead tissue. The spots may also appear on the stems and fruit of the plant.The disease can be severe enough to kill the plant.';
      control = 'Sow only seed that has been tested and certified free of these bacteria and ensure that transplants are disease-free. Copper sprays can provide moderate levels of protection, although copper-resistant strains have become more common. Avoid overhead irrigation. Rotate to non-host crops and control weeds and volunteer plants. Good sanitation practices, including cleaning of equipment and plowing under all plant debris immediately after harvest, can reduce losses from this disease.';
      return false;
    }
    if (status == 'Early_blight'){
      this.status = 'Early blight';
      cause = 'The most common cause of early blight in tomato leaves is the Alternaria tomatophila and Alternaria solani fungus.';
      symptoms = 'Symptoms may develop on leaves, stems and fruit and typically appear first on older leaves as irregular, dark-brown, necrotic lesions. These lesions expand as disease progresses and they eventually develop concentric, black rings, which give early blight lesions a target-board appearance. A chlorotic area often surrounds leaf lesions. If there are numerous lesions on a leaf, then the entire leaf will turn yellow and senesce. Complete defoliation of plants can occur when conditions are favorable for disease development. Lesions may appear as dark-brown, elongated, sunken areas on stems and petioles.';
      control = 'A fungicide spray program combined with an early blight forecasting system is the most effective means of controlling this disease. Use field sanitation techniques such as crop rotation and weed control, and turn under or remove debris from previous crops to reduce disease severity.';
      return false;
    }
    if (status == 'Late_blight'){
      this.status = 'Late blight';
      cause = 'Late Blight is caused by Phytophthora infestans';
      symptoms = 'The first symptom of late blight is a bending down of petioles of infected leaves. Leaf and stem lesions manifest as large, irregular, greenish, water-soaked patches. These patches enlarge and turn brown and paper-like. During wet weather, Phytophthora infestans will grow and sporulate from lesions on abaxial leaf surfaces. Rapid blighting of foliage may occur during moist, warm periods. Entire fields can develop extensive foliar and fruit damage. Fruit lesions manifest as large, firm, irregular, brownish-green blotches. Surfaces of fruit lesions are rough and greasy in appearance.';
      control = 'Implement an effective spray program to control late blight. Avoid planting on land previously cropped to potatoes or near a potato field because P. infestans is also a pathogen of potato. In protected culture, maintaining lower humidity will discourage infection and disease development.';
      return false;
    }
    if (status == 'Leaf_Mold'){
      this.status = 'Leaf Mold';
      cause = 'Leaf mold is caused by the fungus Pseudocercospora fuligena (synonym = Cercospora fuligena).';
      symptoms = 'The first symptom to appear is a yellowish discoloration on upper leaf surfaces that later expands to form brownish lesions surrounded by yellow halos. When humidity is high, gray to blackish-gray conidia develop on lower leaf surfaces. This disease is sometimes referred to as “black leaf mold” because of this dark fungal sporulation. When Cercospora leaf mold is severe, lesions coalesce resulting in collapse of leaf tissue. Due to similarity of symptoms, Cercospora leaf mold can be confused with leaf mold caused by Passalora fulva.';
      control = 'Use a calendar-based protectant fungicide spray program and resistant varieties to reduce losses from Cercospora leaf mold. Prune and provide adequate plant spacing to encourage air movement within plant canopies, and mulch and furrow or drip irrigate to reduce spread of this pathogen from splashing water. Turn under or remove all plant debris and rotate to non-host crops to lower field inoculum levels.';
      return false;
    }
    if (status == 'Septoria_leaf_spot'){
      this.status = 'Septoria leaf spot';
      cause = 'Septoria leaf spot is caused by the fungus Septoria lycopersici.';
      symptoms = 'Symptoms first appear as small, dark, water-soaked spots on older leaves. Later, the spots enlarge to form circular lesions about five millimeters in diameter. These lesions have black or brown borders with gray centers that are peppered with small, black pycnidia. Lesions on stems, petioles and calyces tend to be elongated with pycnidia developing in centers of lesions. When Septoria leaf spot is severe, lesions coalesce, leaves collapse and eventually plants defoliate';
      control = 'Establish a fungicide spray program in conjunction with cultural practices that lower inoculum potential such as turning under plant debris or plant debris removal. Rotate to a non-host crop for three years to reduce losses from Septoria leaf spot.';
      return false;
    }
    if (status == 'Spider_mites Two-spotted_spider_mite'){
      this.status = 'Spider mites';
      cause = 'Extended periods of hot, dry weather or a lack of natural predators in the environment favors mite buildups.';
      symptoms = 'Symptoms may include discoloration, mottling, stippling, or webbing on the leaves. In severe cases, the leaves may turn brown and drop off the plant.';
      control = 'Natural enemies of mites are present in and around fields and can keep mite populations low. Many insecticides used for control of insect pests severely reduce numbers of beneficial insects that keep mite populations in check. Therefore, apply insecticides only as‑needed, rather than at regularly scheduled intervals. When possible, select  pesticides which will have the least impact on beneficial insects.';
      return false;
    }
    if (status == 'Target_Spot'){
      this.status = 'Target spot';
      cause = 'Target spot is caused by Corynespora cassiicola.';
      symptoms = 'All above-ground parts of tomato plants can be infected by Corynespora cassiicola. Symptoms begin on leaves as tiny lesions that rapidly enlarge and develop into lightbrown lesions with distinct yellow halos. Often, lesions grow together causing infected leaf tissue to collapse. Symptoms on stems also begin as small lesions that rapidly enlarge and elongate, and may eventually girdle stems, resulting in collapse of foliage above where stems were girdled. When disease is severe, numerous leaf and stem lesions form on plants causing extensive tissue collapse and eventually plant death. Infection of immature fruit begins as minute, dark-brown, sunken spots that enlarge as the disease progresses. Large, brown, circular lesions with cracked centers develop on mature fruit. Fungal sporulation commonly occurs from these lesions.';
      control = 'Initiate a fungicide spray program prior to the onset of symptoms to help reduce Initial leaf lesions. losses from target spot';
      return false;
    }
    if (status == 'Tomato_Yellow_Leaf_Curl_Virus'){
      this.status = 'Tomato yellow leaf curl virus';
      cause = 'Tomato yellow leaf curl is mainly caused by Tomato Yellow Leaf Curl Virus (TYLCV).';
      symptoms = 'TYLCV caused a range of symptoms that include marginal leaf yellowing, upward or downward leaf cupping, reduction in leaf size, flower and/or fruit drop, and plant stunting.';
      control = 'Management of TYLCV is a multi-step strategy : \n  - Symptomatic plants should be carefully covered by a clear or black plastic bag and tied at the stem at soil line. Cut off the plant below the bag and allow bag with plant and whiteflies to desiccate to death on the soil surface for 1-2 days prior to placing the plant in the trash. \n  - If symptomatic plants have no obvious whiteflies on the lower leaf surface, these plants can be cut from the garden and BURIED in the compost. \n - Inspect plants for whitefly infestations two times per week. If whiteflies are beginning to appear, spray with azadirachtin (Neem), pyrethrin or insecticidal soap. For more effective control, it is recommended that at least two of the above insecticides be rotated at each spraying.';
      return false;
    }
    if (status == 'Tomato_mosaic_virus'){
      this.status = 'Tomato mosaic virus';
      cause = 'Tomato mosaic is caused by Tomato mosaic virus (ToMV).';
      symptoms = 'Typical symptoms include a light and dark green mottling of the leaf tissue and stunting of the plant. Foliar symptoms can vary from a chlorotic mottling to necrosis to upward leaf rolling and stem streaking, depending on which strain of ToMV infects the plant. During cool temperatures, leaves may develop a “fern leaf” appearance where the leaf blade is greatly reduced. During high temperatures, foliar symptoms may be masked. Occasionally the fruit will show disease symptoms, which vary from an uneven ripening to an internal browning of the fruit wall (brown wall). Brown wall typically occurs on the fruit of the first two clusters and appears several days prior to foliar symptoms. Under certain environmental conditions, some varieties with resistance (heterozygous) to ToMV will show necrotic streaks or spots on the stem, petiole, and foliage as well as on the fruit. ';
      control = 'The use of ToMV-resistant varieties is generally the best way to reduce losses from this disease. Avoid planting in soil from previous crops that were infected with ToMV. Steam sterilizing the potting soil and containers as well as all equipment after each crop can reduce disease incidence. Before handling containers or plants be sure all workers wash with soap and water. Sterilizing pruning utensils or snapping off suckers without touching the plant instead of knife pruning helps reduce disease incidence. Direct seeding in the field can help reduce the spread of ToMV.';
      return false;
    }
        this.status = 'Healthy';
        return true;

  }

}
