import 'package:flutter/material.dart';

class MoistureGadget extends StatelessWidget {
  final IconData icon;
  final value;

  MoistureGadget(this.value, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.lightBlue,
            size: 70,
          ),
          Text('$value%',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
