import 'package:flutter/material.dart';
import 'package:internet_of_tomato_farming/pages/home/dashboardGadgets.ui.dart';
import 'package:internet_of_tomato_farming/shared/notificationService.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int unreadNotifications = NotificationService().getUnreadNotificationNumber();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                  label: (unreadNotifications > 0) ? Text(unreadNotifications.toString()) : Container(),
                  icon: Icon(Icons.notifications_active, size: 25,
                      color: (unreadNotifications > 0) ? Colors.white : Colors.lightGreen
                  ),
                  backgroundColor: (unreadNotifications > 0) ? Colors.redAccent : Colors.white,
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  }),
            ),
          ]
      ),
      body: DashboardGadgets()
    );
  }
}
