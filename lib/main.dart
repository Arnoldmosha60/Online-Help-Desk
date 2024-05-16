import 'package:flutter/material.dart';
import 'package:new_helpdesk/drawer_screen.dart';
import 'package:new_helpdesk/pages/chart.dart';
import 'package:new_helpdesk/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            LoginPage()
          ],
        ),
      ),
    );
  }
}