import 'package:flutter/material.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.5,0.9],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.lightGreenAccent])
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image.asset("assets/images/Logo.png", height: 200),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please enter your pin code", style: TextStyle(fontSize: 18)),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 100),
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            fillColor: Colors.white,filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: OutlineInputBorder(),
                            labelText: "PIN Code",
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
