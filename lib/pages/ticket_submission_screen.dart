// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_helpdesk/auth/baseUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketSubmissionScreen extends StatefulWidget {
  const TicketSubmissionScreen({Key? key}) : super(key: key);

  @override
  _TicketSubmissionScreenState createState() => _TicketSubmissionScreenState();
}

class _TicketSubmissionScreenState extends State<TicketSubmissionScreen> {
  final TextEditingController _issueController = TextEditingController();
  String _selectedCategory = 'Health';
  String _selectedUrgency = 'Normal';

  List<String> _categories = ['Health', 'Education', 'Religion', 'Other'];
  List<String> _urgencyLevels = ['Critical', 'Normal', 'Low'];

  Future<void> _submitTicket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? user = prefs.getString('user');

    Map<String, dynamic> userData = jsonDecode(user!);

    final Uri url =
        Uri.parse('${baseURL}api/helpdesk/issues/'); 
    final Map<String, dynamic> data = {
      'issue_description': _issueController.text,
      'category': _selectedCategory,
      'urgency_level': _selectedUrgency,
      'user': userData['id'],
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // Ticket submitted successfully
        // Handle success scenario (e.g., navigate to another screen, show success message)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ticket submitted successfully'),
          ),
        );
      } else {
        // Handle error scenario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit ticket. Please try again.'),
          ),
        );
      }
    } catch (error) {
      // Handle network or server errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

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
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                items: _categories
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedUrgency,
                onChanged: (String? value) {
                  setState(() {
                    _selectedUrgency = value!;
                  });
                },
                items: _urgencyLevels
                    .map((urgency) => DropdownMenuItem<String>(
                          value: urgency,
                          child: Text(urgency),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Urgency Level',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select an urgency level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              RawMaterialButton(
                onPressed: _submitTicket,
                elevation: 0.0,
                constraints: const BoxConstraints.tightFor(
                  width: 150.0,
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
                    SizedBox(
                      width: 5.0,
                    ),
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
