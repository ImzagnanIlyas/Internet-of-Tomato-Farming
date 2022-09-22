import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PhGadget extends StatefulWidget {
  @override
  State<PhGadget> createState() => _PhState();
}
class _PhState extends State<PhGadget> {
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
            radiusFactor: 1.2,
            majorTickStyle: MajorTickStyle(
                length: 0.1,
                thickness: 2,
                lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: MinorTickStyle(
                length: 0.05,
                thickness: 1.5,
                lengthUnit: GaugeSizeUnit.factor),
            startAngle: 180,
            endAngle: 0,
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
                  value: -60, needleColor: Colors.black,
                  tailStyle: TailStyle(length: 0.18, width: 8,
                      color: Colors.black,
                      lengthUnit: GaugeSizeUnit.factor),
                  needleLength: 0.4,
                  needleStartWidth: .5,
                  needleEndWidth: 4,
                  knobStyle: KnobStyle(knobRadius: 0.07,
                      color: Colors.white, borderWidth: 0.05,
                      borderColor: Colors.black),
                  lengthUnit: GaugeSizeUnit.factor)
            ],
            annotations: <GaugeAnnotation>[

            ],
          ),
        ],
    );
  }
}