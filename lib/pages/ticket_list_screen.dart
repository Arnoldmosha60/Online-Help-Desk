// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:new_helpdesk/auth/baseUrl.dart';
import 'package:new_helpdesk/pages/issue_response_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

void main() => runApp(const TicketListApp());

class TicketListApp extends StatelessWidget {
  const TicketListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ticket List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Handle logout
                // Clear user session and navigate to login page
              },
            )
          ],
        ),
        body: const TicketListScreen(),
      ),
    );
  }
}

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({Key? key}) : super(key: key);

  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  List<Ticket> tickets = [];

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? user = prefs.getString('user');

    Map<String, dynamic> userData = jsonDecode(user!);
    String userId = userData['id'];

    final Uri url = Uri.parse('${baseURL}api/helpdesk/issues/$userId/');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> ticketData = json.decode(response.body);
      setState(() {
        tickets = ticketData.map((data) => Ticket.fromJson(data)).toList();
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: tickets.map((ticket) => TicketCard(ticket: ticket)).toList(),
      ),
    );
  }
}

class Ticket {
  final String id;
  final String issueDescription;
  final String category;
  final String urgencyLevel;
  final String submittedOn;
  final bool status;

  Ticket({
    required this.id,
    required this.issueDescription,
    required this.category,
    required this.urgencyLevel,
    required this.submittedOn,
    required this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      issueDescription: json['issue_description'],
      category: json['category'],
      urgencyLevel: json['urgency_level'],
      submittedOn: json['submitted_on'],
      status: json['status'], 
    );
  }
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shadowColor: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Issue: ${ticket.issueDescription}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Category: ${ticket.category}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Urgency: ${ticket.urgencyLevel}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Submitted On: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(ticket.submittedOn))}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: ${ticket.status ? 'Closed' : 'Open'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                if (ticket.status)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  IssueResponseScreen(ticketId: ticket.id),
                            ),
                          );
                        },
                        child: const Text('View Responses'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IssueResponse {
  final String response;
  final String replyDate;

  IssueResponse({
    required this.response,
    required this.replyDate,
  });

  factory IssueResponse.fromJson(Map<String, dynamic> json) {
    return IssueResponse(
      response: json['response'],
      replyDate: json['reply_date'],
    );
  }
}
