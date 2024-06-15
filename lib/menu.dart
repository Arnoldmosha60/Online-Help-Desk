// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:new_helpdesk/pages/dashboardscreen.dart';
import 'package:new_helpdesk/pages/ticket_list_screen.dart';
import 'package:new_helpdesk/pages/ticket_submission_screen.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  late final onPressed;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Dashboard(), 
    const TicketListScreen(),
    const TicketSubmissionScreen(),
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: GNav(
          gap: 8,
          activeColor: Colors.blue,
          padding: const EdgeInsets.all(8.0),
          color: Colors.black,
          selectedIndex: _selectedIndex,
          onTabChange: onTap,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.list,
              text: 'Tickets',
            ),
            GButton(
              icon: Icons.send,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
