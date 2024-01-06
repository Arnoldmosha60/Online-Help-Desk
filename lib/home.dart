import 'package:flutter/material.dart';
import 'package:new_helpdesk/ticket_list_screen.dart';
import 'loginscreen.dart';
import 'dashboardscreen.dart';
import 'ticket_submission_screen.dart';
import 'package:new_helpdesk/settingscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Desk'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(19, 6, 107, 147),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings Icon',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Login Screen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Dashboard Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardScreen()),
                );
              },
              child: const Text('Dashboard'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Ticket Submission Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TicketSubmissionScreen()),
                );
              },
              child: const Text('Submit Ticket'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Ticket Submission Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketListScreen()),
                );
              },
              child: const Text('My Ticket'),
            ),
          ],
        ),
      ),
    );
  }
}
