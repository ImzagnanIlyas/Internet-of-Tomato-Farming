import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// class HumidityGadget extends StatefulWidget {
//   var valueHumidity;
//
//   HumidityGadget(this.valueHumidity);
//
//   @override
//   State<HumidityGadget> createState() => _HumidityGadgetState(valueHumidity);
// }

class HumidityGadget extends StatelessWidget {
  // final ValueListenable<double> valueHumidity;

  var valueHumidity;


  HumidityGadget(this.valueHumidity);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 100,
                interval: 10,
                startAngle: 115,
                endAngle: 65,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                    thickness: 0.1,
                    thicknessUnit: GaugeSizeUnit.factor,
                    color: Colors.black12,
                    cornerStyle: CornerStyle.bothCurve
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: valueHumidity,
                      width: 10,
                      color: Colors.lightBlueAccent,
                      cornerStyle: CornerStyle.bothCurve
                  ),
                  MarkerPointer(
                    value: valueHumidity,
                    markerHeight: 10, markerWidth: 10,
                    markerType: MarkerType.circle, color: Colors.white,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      axisValue: 50,
                      widget: Text(valueHumidity.toString()+' %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.lightBlueAccent
                          )
                      )
                  )
                ]
            ),
          ]
      ),
    );
  }
}
