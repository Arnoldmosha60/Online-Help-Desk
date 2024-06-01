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
    Ticket(id: '1', title: 'Issue 1', status: 'Open', imageUrl: 'https://example.com/image1.jpg'),
    Ticket(id: '2', title: 'Issue 2', status: 'In Progress', imageUrl: 'https://example.com/image2.jpg'),
    Ticket(id: '3', title: 'Issue 3', status: 'Closed', imageUrl: 'https://example.com/image3.jpg'),
    // Add more tickets as needed
  ];

 TicketListScreen({super.key});

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
  final String imageUrl; // New field for image URL

  Ticket({required this.id, required this.title, required this.status, required this.imageUrl});
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50, // Set card width as desired
      height: 50, // Set card height as desired
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shadowColor: Colors.blueAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              ticket.imageUrl,
              width: double.infinity,
              height: 150, // Adjust image height as needed
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${ticket.title} - ${ticket.status}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
