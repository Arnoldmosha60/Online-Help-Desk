import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:ui';
import 'chart/pie_chart.dart';
import 'chart/piez-chart_data.dart';

List<PieChartSectionData> pieChartSectionData = [
  PieChartSectionData(
    value: 20,
    title: '20%',
    color: const Color(0xffed733f),
  ),
  PieChartSectionData(
    value: 35,
    title: '35%',
    color: const Color(0xff584f84),
  ),
  PieChartSectionData(
    value: 15,
    title: '15%',
    color: const Color(0xffd86f9b),
  ),
  PieChartSectionData(
    value: 30,
    title: '30%',
    color: const Color(0xffa2663e),
  ),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Set the preferred height of the AppBar
        child: AppBar(
          elevation: 5,
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0), // Add padding from the top
            child: Text(
              'Help Desk',
              style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.lightBlue,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          automaticallyImplyLeading: false, // Disable the default leading icon
        ),
      ),
      body: Container(
        color: const Color(0xfff0f0f0),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
          children: <Widget>[
            ChartContainer(
                title: 'Pie Chart',
                color: const Color(0xff24b273),
                chart: PieChartContent()
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100.0, // Set the height of the drawer header
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close), // Icon for closing the drawer
                      onPressed: () {
                        Navigator.pop(context); // Close the drawer
                      },
                    ),
                    const Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 40), // Adjust the width as needed
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('All'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('In Progress'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Closed'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('FAQs'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
