import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/repos/firebaseHelperRepo.dart';

class ThresholdsForm extends StatefulWidget {
  const ThresholdsForm({Key? key}) : super(key: key);

  @override
  State<ThresholdsForm> createState() => _ThresholdsFormState();
}

class _ThresholdsFormState extends State<ThresholdsForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  var airTempMinTEC = TextEditingController(text: "-40");
  var airTempMaxTEC = TextEditingController(text: "85");

  var soilTempMinTEC = TextEditingController(text: "-40");
  var soilTempMaxTEC = TextEditingController(text: "85");

  var humidityMinTEC = TextEditingController(text: "0");
  var humidityMaxTEC = TextEditingController(text: "100");

  var moistureMinTEC = TextEditingController(text: "0");
  var moistureMaxTEC = TextEditingController(text: "100");

  var phMinTEC = TextEditingController(text: "0");
  var phMaxTEC = TextEditingController(text: "14");

  var nMinTEC = TextEditingController(text: "0");
  var nMaxTEC = TextEditingController(text: "10000");

  var pMinTEC = TextEditingController(text: "0");
  var pMaxTEC = TextEditingController(text: "4000");

  var kMinTEC = TextEditingController(text: "0");
  var kMaxTEC = TextEditingController(text: "10000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thresholds Form"),
      ),
      body: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "°C"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     airTempMinTEC,
                          validator: _buildValidator(-40,85),
                        ),
                      ),
                      Text("Air Temperature",
                        style: TextStyle(fontSize: 15),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max", "°C"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     airTempMaxTEC,
                          validator: _buildValidator(-40,85),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "°C"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     soilTempMinTEC,
                          validator: _buildValidator(-40,85),
                        ),
                      ),
                      Text("Soil Temperature",
                        style: TextStyle(fontSize: 15),
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max", "°C"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     soilTempMaxTEC,
                          validator: _buildValidator(-40,85),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "%"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     humidityMinTEC,
                          validator: _buildValidator(0,100),
                        ),
                      ),
                      Text("Humidity", style: TextStyle(fontSize: 15)),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max", "%"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     humidityMaxTEC,
                          validator: _buildValidator(0,100),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "%"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     moistureMinTEC,
                          validator: _buildValidator(0,100),
                        ),
                      ),
                      Text("Moisture", style: TextStyle(fontSize: 15)),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max", "%"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     moistureMaxTEC,
                          validator: _buildValidator(0,100),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", ""),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     phMinTEC,
                          validator: _buildValidator(0,14),
                        ),
                      ),
                      Text("pH", style: TextStyle(fontSize: 15)),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max", ""),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     phMaxTEC,
                          validator: _buildValidator(0,14),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "ppm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     nMinTEC,
                          validator: _buildValidator(0,10000),
                        ),
                      ),
                      Text("NPK: nitrogen(N)", style: TextStyle(fontSize: 15)),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max","ppm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     nMaxTEC,
                          validator: _buildValidator(0,10000),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "ppm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     pMinTEC,
                          validator: _buildValidator(0,4000),
                        ),
                      ),
                      Text("NPK: phosphorus(P)", style: TextStyle(fontSize: 15)),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max","ppm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     pMaxTEC,
                          validator: _buildValidator(0,4000),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 2),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Min", "ppm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     kMinTEC,
                          validator: _buildValidator(0,10000),
                        ),
                      ),
                      Text("NPK: potassium(K)", style: TextStyle(fontSize: 15)),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: _buildInputDecoration("Max","ppm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller:     kMaxTEC,
                          validator: _buildValidator(0,10000),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSavePressed,
                      child: Text("Save"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  void _onSavePressed(){
    if(_formKey.currentState!.validate()){
      Map<String, dynamic> data = {
      "thresholdTempAirMin":airTempMinTEC.text,
      "thresholdTempAirMax":airTempMaxTEC.text,
      "thresholdTempSoilMin":soilTempMinTEC.text,
      "thresholdTempSoilMax":soilTempMaxTEC.text,
      "thresholdHumidityMin":humidityMinTEC.text,
      "thresholdHumidityMax":humidityMaxTEC.text,
      "thresholdMoistureMin":moistureMinTEC.text,
      "thresholdMoistureMax":moistureMaxTEC.text,
      "thresholdPhMin":phMinTEC.text,
      "thresholdPhMax":phMaxTEC.text,
      "thresholdNMin":nMinTEC.text,
      "thresholdNMax":nMaxTEC.text,
      "thresholdPMin":pMinTEC.text,
      "thresholdPMax":pMaxTEC.text,
      "thresholdKMin":kMinTEC.text,
      "thresholdKMax":kMaxTEC.text
      };
      FirebaseHelperRepo().saveThresholds(data);
      Navigator.pushNamed(context, "/GridForm");
    }
  }

  InputDecoration _buildInputDecoration(String label,String suffix){
    return InputDecoration(
        labelText: label,
        fillColor: Colors.grey[200],
        filled: true,
        suffixText: suffix,
        contentPadding: const EdgeInsets.all(10.0)
    );
  }

  String? Function(String? value) _buildValidator(double min, double max){
    return (String? value){
      if (value == null || value.isEmpty) {
        return 'Empty';
      }
      var d = double.tryParse(value);
      if (d == null) {
        return 'Numeric value';
      }
      if (d < min || d > max) {
        return '${min} - ${max}';
      }

      return null;
    };
  }
}
