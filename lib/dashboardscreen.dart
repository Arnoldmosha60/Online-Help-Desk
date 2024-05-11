import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:new_helpdesk/drawer_screen.dart';
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
double xOffset = 0;
double yOffset = 0;

bool isDrawerOpen = false;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
              100.0), // Set the preferred height of the AppBar
          child: AppBar(


            elevation: 5,
            title: const Padding(
              padding: EdgeInsets.only(top: 20.0), // Add padding from the top
              child: Text(
                'Help Desk',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Colors.lightBlue,
            leading: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // scaffoldKey.currentState?.openDrawer();
                  Navigator.push(context, MaterialPageRoute(builder:(context) => DrawerScreen()));

                },
              ),
            ),
            automaticallyImplyLeading:
                false, // Disable the default leading icon
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
                  chart: PieChartContent()),
            ],
          ),
        ),
        // drawer: Drawer(
        //     child: Container(
        //   color: Colors.blueGrey,
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: <Widget>[
        //         Row(
        //           children: <Widget>[
        //             CircleAvatar(
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(20),
        //                 child: Image(
        //                   fit: BoxFit.cover,
        //                   image: AssetImage('assets/Group.jpg'),
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text(
        //               'Mosallas Group',
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 22,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         ),
        //         Column(
        //           children: <Widget>[
        //             NewRow(
        //               text: 'Settings',
        //               icon: Icons.error_outline,
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             NewRow(
        //               text: 'Profile',
        //               icon: Icons.person_outline,
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             NewRow(
        //               text: 'Messages',
        //               icon: Icons.chat_bubble_outline,
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             NewRow(
        //               text: 'Saved',
        //               icon: Icons.bookmark_border,
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             NewRow(
        //               text: 'Favorites',
        //               icon: Icons.favorite_border,
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             NewRow(
        //               text: 'Hint',
        //               icon: Icons.lightbulb_outline,
        //             ),
        //             SizedBox(
        //               height: 20,
        //             ),
        //           ],
        //         ),
        //         Row(
        //           children: <Widget>[
        //             Icon(
        //               Icons.cancel,
        //               color: Colors.white.withOpacity(0.5),
        //             ),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Text(
        //               'Log out',
        //               style: TextStyle(color: Colors.white.withOpacity(0.5)),
        //             )
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ))
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
