import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Add widgets or data to display on the dashboard
            // For example:
            // Text('Total Tickets: 10'),
            // Text('Open Tickets: 5'),
            // Add more widgets as needed
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
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
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
