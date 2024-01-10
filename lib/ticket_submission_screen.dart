import 'package:flutter/material.dart';

class TicketSubmissionScreen extends StatefulWidget {
  const TicketSubmissionScreen({super.key});

  @override
  _TicketSubmissionScreenState createState() => _TicketSubmissionScreenState();
}

class _TicketSubmissionScreenState extends State<TicketSubmissionScreen> {
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _urgencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _issueController,
                decoration:
                    const InputDecoration(labelText: 'Issue Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description of the issue';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the category of the issue';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _urgencyController,
                decoration: const InputDecoration(labelText: 'Urgency Level'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the urgency level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              RawMaterialButton(
                onPressed: () {

                },
                elevation: 0.0,
                constraints: const BoxConstraints.tightFor(
                  width: 110.0,
                  height: 50.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    width: 1,
                  ),
                ),
                fillColor: Colors.blue,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 5.0,),
                    Text(
                      'Submit Ticket',
                      style: TextStyle(
                        fontSize: 15.0,
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
}
