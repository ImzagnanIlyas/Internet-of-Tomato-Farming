import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home/dashboardGadgets.ui.dart';
import 'package:internet_of_tomato_farming/pages/home/heatmap/heatmap.page.dart';
import 'package:internet_of_tomato_farming/pages/home/take-picture/takePictureScreen.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // int unreadNotifications = NotificationService().getUnreadNotificationNumber();
  int unreadNotifications = 0;

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardGadgets(),
    Heatmap(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                  label: (unreadNotifications > 0)
                      ? Text(unreadNotifications.toString()) : Container(),
                  icon: Icon(Icons.notifications_active, size: 25,
                      color: (unreadNotifications > 0)
                          ? Colors.white : Colors.lightGreen
                  ),
                  backgroundColor: (unreadNotifications > 0)
                      ? Colors.redAccent : Colors.white,
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  }),
            ),
          ]
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:  BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Heatmap',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushToTakePictureScreen,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _pushToTakePictureScreen() async{
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TakePictureScreen(firstCamera))
    );
  }
}
