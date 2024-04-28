import 'package:flutter/material.dart';

class Tab extends StatefulWidget {
  final String text;
  final Icon icon;

  const Tab({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<Tab> createState() => _TabState();
}

class _TabState extends State<Tab> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _selectedColor = const Color(0xff1a73e8);
  final _unselectedColor = const Color(0xff5f6368);
  late final List<Tab> _tabs;
  late final List<Tab> _iconTabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      const Tab(text: 'Tab1', icon: Icon(Icons.cabin)),
      const Tab(text: 'Tab2', icon: Icon(Icons.cabin)),
      const Tab(text: 'Tab3', icon: Icon(Icons.cabin)),
    ];
    _iconTabs = [
      const Tab(icon: Icon(Icons.home), text: ''),
      const Tab(icon: Icon(Icons.search), text: ''),
      const Tab(icon: Icon(Icons.settings), text: ''),
    ];
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TabBar(
        controller: _tabController,
        tabs: _tabs,
        labelColor: _selectedColor,
        indicatorColor: _selectedColor,
        unselectedLabelColor: _unselectedColor,
      ),
    );
  }
}
