import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool receiveNotifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text('Receive Notifications'),
              value: receiveNotifications,
              onChanged: (value) {
                setState(() {
                  receiveNotifications = value;
                });
                // Update user preferences for notifications
              },
            ),
            SizedBox(height: 20),
            Text(
              'Appearance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                  // Update user preferences for dark mode
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
