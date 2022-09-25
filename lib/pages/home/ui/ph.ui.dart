import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PhGadget extends StatefulWidget {
  double valuePh;
  PhGadget(this.valuePh);

  @override
  State<PhGadget> createState() => _PhState(valuePh);
}
class _PhState extends State<PhGadget> {
  double valuePh = 0;

  _PhState(this.valuePh);

  double width = 0.4;


  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 15,
            showLabels: false,
            axisLineStyle: AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor,
              thickness: 0.1,
              cornerStyle: CornerStyle.bothCurve
            ),
            startAngle: 115,
            endAngle: 65,
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 1,
                color: Color(0xFFed1c24),
                label: '0',
                labelStyle: GaugeTextStyle(color: Colors.white),
                gradient: const SweepGradient(
                    colors: <Color>[Color(0xFFed1c24), Color(0xFFf96e3b)],
                    stops: <double>[0.1, 1]
                ),
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: width, endWidth: width),
              GaugeRange(startValue: 1, endValue: 2,
                  color: Color(0xFFf96e3b),
                  label: '1',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFFf96e3b), Color(0xFFf7b517)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 2, endValue: 3,
                  color: Color(0xFFf7b517), label: '2',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFFf7b517), Color(0xFFfff735)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 3, endValue: 4,
                  color: Color(0xFFfff735), label: '3',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFFfff735), Color(0xFFcae801)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 4, endValue: 5,
                  color: Color(0xFFcae801), label: '4',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFFcae801), Color(0xFF8ed404)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 5, endValue: 6,
                  color: Color(0xFF8ed404), label: '5',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF8ed404), Color(0xFF4cbf04)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 6, endValue: 7,
                  color: Color(0xFF4cbf04), label: '6',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF4cbf04), Color(0xFF01ab04)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 7, endValue: 8,
                  color: Color(0xFF01ab04), label: '7',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF01ab04), Color(0xFF01b974)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 8, endValue: 9,
                  color: Color(0xFF01b974), label: '8',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF01b974), Color(0xFF00c9c9)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 9, endValue: 10,
                  color: Color(0xFF00c9c9), label: '9',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF00c9c9), Color(0xFF039cdb)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 10, endValue: 11,
                  color: Color(0xFF039cdb), label: '10',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF039cdb), Color(0xFF006be7)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 11, endValue: 12,
                  color: Color(0xFF006be7), label: '11',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF006be7), Color(0xFF3a5cde)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 12, endValue: 13,
                  color: Color(0xFF3a5cde), label: '12',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF3a5cde), Color(0xFF6a4bd5)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 13, endValue: 14,
                  color: Color(0xFF6a4bd5), label: '13',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF6a4bd5), Color(0xFF5b3ab0)],
                      stops: <double>[0.1, 1]
                  ),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
              GaugeRange(startValue: 14, endValue: 15,
                  color: Color(0xFF5b3ab0), label: '14',
                  labelStyle: GaugeTextStyle(color: Colors.white),
                  sizeUnit: GaugeSizeUnit.factor,
                  startWidth: width, endWidth: width),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: valuePh,
                lengthUnit: GaugeSizeUnit.factor,
                needleLength: 0.7,
                needleStartWidth: 0.5, needleEndWidth: 4,
                knobStyle: KnobStyle(
                    knobRadius: 0.1,
                    sizeUnit: GaugeSizeUnit.factor
                )
              ),
              // NeedlePointer(
              //     value: -60, needleColor: Colors.black,
              //     tailStyle: TailStyle(length: 0.18, width: 8,
              //         color: Colors.black,
              //         lengthUnit: GaugeSizeUnit.factor),
              //     needleLength: 0.4,
              //     needleStartWidth: .5,
              //     needleEndWidth: 4,
              //     knobStyle: KnobStyle(knobRadius: 0.07,
              //         color: Colors.white, borderWidth: 0.05,
              //         borderColor: Colors.black),
              //     lengthUnit: GaugeSizeUnit.factor)
            ],
            annotations: <GaugeAnnotation>[

            ],
          ),
        ],
    );
  }
}