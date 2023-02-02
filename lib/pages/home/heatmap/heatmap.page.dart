import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/repos/productRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Heatmap extends StatefulWidget {
  const Heatmap({Key? key}) : super(key: key);

  @override
  State<Heatmap> createState() => _HeatmapState();
}

class _HeatmapState extends State<Heatmap> {
  late SharedPreferences prefs;
  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();

  List<double> zoomValues = [0.25,0.50,0.75,1,1.25,1.50,1.75,2];
  int selectedZoomValueIndex = 3;

  List<String> sensorsList = <String>['tempAir', 'tempSoil', 'humidity',
    'moisture', 'ph', 'npk'];
  Map<String, String> sensorsLabel = {
    "tempAir": "Air Temperature",
    "tempSoil": "Soil Temperature",
    "humidity": "Humidity",
    "moisture": "Moisture",
    "ph": "pH",
    "npk": "NPK",
  };
  String dropdownValue = 'tempAir';

  ProductRepo _productRepo = ProductRepo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: (){
                          if(selectedZoomValueIndex>0) setState(() {
                            selectedZoomValueIndex--;
                          });
                        },
                        icon: Icon(Icons.remove_circle,
                            color: Colors.redAccent
                        )
                    ),
                    Container(
                      width: 75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Zoom",
                              style: Theme.of(context).textTheme.subtitle2
                          ),
                          Text('${(zoomValues[selectedZoomValueIndex]*100).toInt()}',
                              style: Theme.of(context).textTheme.subtitle1
                          )
                        ],
                      )
                    ),
                    IconButton(
                        onPressed: (){
                          if(selectedZoomValueIndex<zoomValues.length-1)
                            setState(() {
                              selectedZoomValueIndex++;
                            });
                        },
                        icon: Icon(Icons.add_circle,
                            color: Colors.green
                        )
                    ),
                  ],
                ),
                DropdownButton(
                  value: dropdownValue,
                  items: sensorsList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(sensorsLabel[value] ?? ""),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              color: Colors.white,
              child: Scrollbar(
                controller: _vertical,
                trackVisibility: true,
                isAlwaysShown: true,
                child: Scrollbar(
                  controller: _horizontal,
                  trackVisibility: true,
                  isAlwaysShown: true,
                  notificationPredicate: (notif) => notif.depth == 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SingleChildScrollView(
                      controller: _vertical,
                      child: SingleChildScrollView(
                        controller: _horizontal,
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                          future: SharedPreferences.getInstance(),
                          builder: (context, AsyncSnapshot<SharedPreferences> snap){
                            if(snap.hasData)
                              prefs = snap.data!;
                              return StreamBuilder(
                                  stream: _productRepo.getNodesDataStream(),
                                  builder: _streamBuilder
                              );
                            return CircularProgressIndicator();
                          },
                          // child: StreamBuilder(
                          //     stream: _productRepo.getNodesDataStream(),
                          //     builder: _streamBuilder
                          // ),
                        ),
                        // child: _buildMap(zoomValues[selectedZoomValueIndex])
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          _buildHeatmapKey()
        ],
      ),
    );
  }

  Widget _buildMap(int cols, int rows, double zoom, Map data){
    List<Widget> grids = [];

    double width = MediaQuery.of(context).size.width*zoom;
    double height = MediaQuery.of(context).size.height*zoom;
    height -= 250;
    width  -= 60;
    if(cols==rows){
      if (height > width) height = width;
      else width = height;
    }


    for(int i=1; i<=rows ;i++){
      List<Widget> itemPerRow = [];
      for(int j=1; j<=cols ;j++){
        var node = data["$i$j"];
        var value = (node != null) ? node["values"][dropdownValue] : null;
        itemPerRow.add(Tooltip(
          message: (value!=null)
              ? (dropdownValue == 'npk')
                ? 'Position: $i,$j\nN: ${value["n"].toStringAsFixed(1)} | P: ${value["n"].toStringAsFixed(1)} | K: ${value["k"].toStringAsFixed(1)}'
                : 'Position: $i,$j\nValue: ${value.toStringAsFixed(1)}'
              : "",
          preferBelow: false,
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 2),
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
          child: Container(
            alignment: Alignment.center,
            width: (rows > cols) ? height / rows : width / cols,
            height: (cols > rows) ? width / cols : height / rows,
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.white),
                color: (value!=null && dropdownValue != 'npk')
                    ? getNodeColor(value.toDouble())
                    : Colors.grey[200]
            ),
            child: (value!=null)
                ? (dropdownValue == 'npk')
                  ? _buildNPKNode(value)
                  : Text("")
                : Icon(Icons.wifi_off, size: 12),
          ),
        ));
      }
      grids.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: itemPerRow,
      ));

    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: grids,
    );
  }

  Widget _buildNPKNode(var value){
    return Column(
      children: [
        Expanded(child: Container(
          color: getNodeColor(value["n"], "N"),
        )),
        Expanded(child: Container(
          color: getNodeColor(value["p"], "P"),
        )),
        Expanded(child: Container(
          color: getNodeColor(value["k"], "K"),
        )),
      ],
    );
  }

  Widget _streamBuilder(context, AsyncSnapshot<DatabaseEvent> snap){
    Map? data = snap.data?.snapshot.value as Map?;
    if(data !=null) {
      int? cols = prefs.getInt("field-cols");
      int? rows = prefs.getInt("field-rows");
      if(cols==null || rows==null)
        return Text("Missing data, Please refill grid form");
      else
        return _buildMap(cols, rows, zoomValues[selectedZoomValueIndex], data);
    }
    return CircularProgressIndicator();
  }

  Color getNodeColor(var value,[String? nutrient]){
    int red = 255, green = 255, blue = 255;
    double opacity = 0.7;

    if(dropdownValue=="tempAir" || dropdownValue=="tempSoil"){
      // Map to a value between 0 and 1
      double t = (value + 40) / 125;

      red = (t >= 4/6) ? 255
          : (t > 3/6) ? (255*((t-3/6)/(4/6-3/6))).toInt()
          : 0;
      green = (t < 2/6) ? (100+155*(t / (2/6))).toInt()
          : (t > 4/6) ? (255*(1-(t-4/6)/(1-4/6))).toInt()
          : 255 ;
      blue = (t <= 2/6) ? 255
          : (t < 3/6) ? (255*(1-(t-2/6)/(3/6-2/6))).toInt()
          : 0;
    }
    else if(dropdownValue=="humidity" || dropdownValue=="moisture"){
      double t = value/100;
      red = 0;
      green = (255*(1-t)).toInt();
      blue = 255;
    }
    else if(dropdownValue=="ph"){
      double t = value/14;
      red = (t <= 0.25) ?  255
          : (t < 0.5) ? ( 255*( 1 - (t-0.25)/0.25) ).toInt()
          : (t > 5/6) ? ( 127*( (t-5/6)/(1-5/6) ) ).toInt()
          : 0;
      green = (t < 0.25) ? ( 255*( t/0.25 ) ).toInt()
          : (t <= 4/6) ? 255
          : (t < 5/6) ? ( 255*( 1 - (t-4/6)/(1/6) ) ).toInt()
          : 0;
      blue = (t <= 0.5) ? 0
          : (t < 4/6) ? ( 255*( (t-0.5)/(4/6-0.5) ) ).toInt()
          : 255;
    }
    else if(dropdownValue=="npk"){
      double t = (nutrient=="P" || nutrient=="K") ? value/10000 : value/3000;
      red = 255;
      green = (255 * (1 - t)).toInt();
      blue = 0;
    }

    return Color.fromRGBO(red, green, blue, opacity);
  }

  Widget _buildHeatmapKey(){
    if(dropdownValue=="tempAir" || dropdownValue=="tempSoil"){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("-40"),
              Text("20"),
              Text("85"),
            ],
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(0, 100, 255, 0.7),
                  Color.fromRGBO(0, 255, 255, 0.7),
                  Color.fromRGBO(0, 255, 0, 0.7),
                  Color.fromRGBO(255, 255, 0, 0.7),
                  Color.fromRGBO(255, 0, 0, 0.7),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          )
        ],
      );
    }
    else if(dropdownValue=="humidity" || dropdownValue=="moisture" ){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0"),
              Text("50"),
              Text("100"),
            ],
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(0, 255, 255, 0.7),
                  Color.fromRGBO(0, 0, 255, 0.7),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          )
        ],
      );
    }
    else if(dropdownValue=="ph"){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" 0"), Text(" 1"), Text(" 2"), Text(" 3"), Text(" 4"),
              Text( "5"), Text(" 6"), Text(" 7"), Text("8"), Text("9"),
              Text("10"), Text("11"), Text("12"), Text("13"), Text("14")
            ],
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(255, 0, 0, 0.7),
                  Color.fromRGBO(255, 127, 0, 0.7),
                  Color.fromRGBO(255, 255, 0, 0.7),
                  Color.fromRGBO(0, 255, 0, 0.7),
                  Color.fromRGBO(0, 255, 255, 0.7),
                  Color.fromRGBO(0, 0, 255, 0.7),
                  Color.fromRGBO(127, 0, 255, 0.7),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          )
        ],
      );
    }
    else if(dropdownValue=="npk"){
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0"),
              Text("N&P:10000 | K:3000"),
            ],
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(255, 255, 0, 0.7),
                  Color.fromRGBO(255, 0, 0, 0.7),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
          )
        ],
      );
    }

    return SizedBox(height: 10);
  }
}
