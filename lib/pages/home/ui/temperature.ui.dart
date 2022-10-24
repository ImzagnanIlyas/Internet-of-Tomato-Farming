import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// class TemperatureGadget extends StatefulWidget {
//   final ValueListenable<double> valueTemp;
//
//   //var valueTemp;
//
//   TemperatureGadget(this.valueTemp, {Key? key}) : super(key: key);
//
//   @override
//   State<TemperatureGadget> createState() => _TemperatureGadgetState(valueTemp.value);
// }
class TemperatureGadget extends StatelessWidget {
  final ValueListenable<double> valueTemp;
  //var valueTemp;


  TemperatureGadget(this.valueTemp);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            ticksPosition: ElementsPosition.outside,
            labelsPosition: ElementsPosition.outside,
            minorTicksPerInterval: 5,
            axisLineStyle: AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor,
              thickness: 0.1,
            ),
            axisLabelStyle: GaugeTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13),
            radiusFactor: 0.97,
            majorTickStyle: MajorTickStyle(
                length: 0.1,
                thickness: 2,
                lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: MinorTickStyle(
                length: 0.05,
                thickness: 1.5,
                lengthUnit: GaugeSizeUnit.factor),
            minimum: 10,
            maximum: 37,
            interval: 3,
            startAngle: 115,
            endAngle: 65,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 10,
                  endValue: 12,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.red,
                  endWidth: 0.1,
                  startWidth: 0.1),
              GaugeRange(
                  startValue: 12,
                  endValue: 35,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.yellow,
                  endWidth: 0.1,
                  startWidth: 0.1),
              GaugeRange(
                  startValue: 20,
                  endValue: 24,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.green,
                  endWidth: 0.1,
                  startWidth: 0.1),
              GaugeRange(
                  startValue: 35,
                  endValue: 40,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.red,
                  endWidth: 0.1,
                  startWidth: 0.1),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                  value: valueTemp.value, needleColor: Colors.black,
                  tailStyle: TailStyle(length: 0.18, width: 8,
                      color: Colors.black,
                      lengthUnit: GaugeSizeUnit.factor),
                  needleLength: 0.68,
                  needleStartWidth: .5,
                  needleEndWidth: 8,
                  knobStyle: KnobStyle(knobRadius: 0.07,
                      color: Colors.white, borderWidth: 0.05,
                      borderColor: Colors.black),
                  lengthUnit: GaugeSizeUnit.factor)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Text(
                    '°C',
                    style:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  positionFactor: 0.8,
                  angle: 90)
            ],
          ),
        ],
    );
  }
}