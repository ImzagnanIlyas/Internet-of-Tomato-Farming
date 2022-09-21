import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/qrViewPage.dart';
import 'package:internet_of_tomato_farming/repos/deviceRepo.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await DeviceRepo.initializeFirebase();
  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.isLogged}) : super(key: key);
  bool isLogged = false;

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/qr': (context) => QRViewPage(),
    '/home': (context) => MyHomePage(title:"IoTF"),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoTF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: (isLogged) ? '/home': '/qr',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void init() async{
    await DeviceRepo.initializeFirebase();
  }

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center()
    );
  }
}