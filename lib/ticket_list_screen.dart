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
      elevation: 20,
      margin: const EdgeInsets.all(32),
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          // Handle tapping on a ticket card (e.g., navigate to ticket details)
          print('Tapped Ticket ${ticket.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ticket ID: ${ticket.id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Title: ${ticket.title}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Status: ${ticket.status}'),
            ),
          ],
        ),
      ),
    );
  }
}
