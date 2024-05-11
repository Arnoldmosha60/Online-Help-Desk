import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const TicketListApp());

class TicketListApp extends StatelessWidget {
  const TicketListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ticket List')),
        body: TicketListScreen(),
      ),
    );
  }
}

class TicketListScreen extends StatelessWidget {
  final List<Ticket> tickets = [
    Ticket(id: '1', title: 'Issue 1', status: 'Open'),
    Ticket(id: '2', title: 'Issue 2', status: 'In Progress'),
    Ticket(id: '3', title: 'Issue 3', status: 'Closed'),
    // Add more tickets as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return TicketCard(ticket: tickets[index]);
      },
    );
  }
}

class Ticket {
  final String id;
  final String title;
  final String status;

  Ticket({required this.id, required this.title, required this.status});
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '${ticket.title} - ${ticket.status}',
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}


