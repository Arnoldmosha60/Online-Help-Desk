import 'dart:async';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _numPages = 5; // Number of cards in the carousel
  final double _cardWidth = 150.0;

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 500, // Adjust width as needed
                height: 200, // Adjust height as needed
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.only(top: 26.0),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Your Card Content Here',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  height: 150, // Adjust height as needed
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _numPages,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCarouselItem(index);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FAQs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const TabBar(
                            tabs: [
                              Tab(text: 'Tab 1'),
                              Tab(text: 'Tab 2'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 200, // Adjust height as needed
                            child: TabBarView(
                              children: [
                                _buildTabContent(1),
                                _buildTabContent(2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4,
        child: SizedBox(
          width: _cardWidth,
          child: Center(
            child: Text(
              'Carousel Item $index',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(int tabIndex) {
  return ListView.builder(
    itemCount: 10, // Number of rectangular cards in each tab
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Container(
          width: double.infinity,
          height: 100, // Adjust card height as needed
          color: Colors.blueGrey,
          child: Center(
            child: Text(
              'Tab $tabIndex Card $index',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    },
  );
}


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
