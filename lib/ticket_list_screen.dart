import 'package:flutter/material.dart';

class TicketListScreen extends StatelessWidget {
  final List<Ticket> tickets = [
    Ticket(id: '1', title: 'Issue 1', status: 'Open'),
    Ticket(id: '2', title: 'Issue 2', status: 'In Progress'),
    Ticket(id: '3', title: 'Issue 3', status: 'Closed'),
    // Add more tickets as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket List'),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return TicketListItem(ticket: tickets[index]);
        },
      ),
    );
  }
}

class Ticket {
  final String id;
  final String title;
  final String status;

  Ticket({required this.id, required this.title, required this.status});
}

class TicketListItem extends StatelessWidget {
  final Ticket ticket;

  TicketListItem({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ticket.title),
      subtitle: Text('Status: ${ticket.status}'),
      onTap: () {
        // Handle tapping on a ticket item (e.g., navigate to ticket details)
      },
    );
  }
}
