import 'package:flutter/material.dart';
import 'package:new_helpdesk/drawer_screen.dart';
import 'package:new_helpdesk/home_mchong0.dart';
import 'package:new_helpdesk/login.dart';

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
            LoginPage(),
          ],
        ),
      ),
    );
  }
}