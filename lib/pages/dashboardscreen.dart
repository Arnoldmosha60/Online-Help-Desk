import 'dart:async';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _numPages = 3; // Number of pages in the carousel

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
    );
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/bg_image.jpg'), // Replace with your background image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/bg_image.jpg'), // Replace with your background image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/bg_image.jpg'), // Replace with your background image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              onPressed: () {
                // Handle menu button tap
              },
              icon: const Icon(Icons.menu,
                  color: Colors.black), // Change back arrow icon to list icon
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle notifications button tap
                    },
                    icon: const Icon(Icons.notifications, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle settings button tap
                    },
                    icon: const Icon(Icons.settings, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle another action button tap
                    },
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSectionTitle(context, 'Help Desk'),
                      _buildHelpDeskCard(),
                      const SizedBox(height: 20),
                      _buildSectionTitle(context, 'Recent Tickets'),
                      _buildTicketList(),
                      const SizedBox(height: 20),
                      _buildSectionTitle(context, 'FAQs'),
                      _buildFAQsTabs(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildHelpDeskCard() {
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Help Desk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'How can we assist you today?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketList() {
    return Column(
      children: [
        _buildTicketItem('Issue 1', 'Open'),
        _buildTicketItem('Issue 2', 'In Progress'),
        _buildTicketItem('Issue 3', 'Closed'),
      ],
    );
  }

  Widget _buildTicketItem(String title, String status) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title),
        subtitle: Text('Status: $status'),
        onTap: () {
          // Handle ticket tap
        },
      ),
    );
  }

  Widget _buildFAQsTabs() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'General FAQs'),
              Tab(text: 'Technical FAQs'),
            ],
          ),
          SizedBox(
            height: 200, // Adjust height as needed
            child: TabBarView(
              children: [
                _buildFAQsList(),
                _buildFAQsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQsList() {
    return ListView(
      children: [
        _buildFAQItem('How to create a new ticket?', 'General'),
        _buildFAQItem('How to reset password?', 'General'),
        _buildFAQItem('How to fix network issues?', 'Technical'),
        _buildFAQItem('How to install updates?', 'Technical'),
      ],
    );
  }

  Widget _buildFAQItem(String question, String category) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(question),
        subtitle: Text('Category: $category'),
        onTap: () {
          // Handle FAQ tap
        },
      ),
    );
  }
}
