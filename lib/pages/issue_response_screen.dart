import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_helpdesk/auth/baseUrl.dart';
import 'package:intl/intl.dart';
import 'package:new_helpdesk/pages/ticket_list_screen.dart';

class IssueResponseScreen extends StatefulWidget {
  final String ticketId;

  const IssueResponseScreen({super.key, required this.ticketId});

  @override
  State<IssueResponseScreen> createState() => _IssueResponseScreenState();
}

class _IssueResponseScreenState extends State<IssueResponseScreen> {
  List<IssueResponse> issueResponses = [];
  bool isLoading = true;
  bool hasError = false;
  TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchIssueResponses();
  }

  Future<void> fetchIssueResponses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final Uri url = Uri.parse('${baseURL}api/helpdesk/issue-response/${widget.ticketId}/');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          issueResponses = responseData.map((data) => IssueResponse.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Future<void> submitFeedback(String responseId, String feedbackText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final Uri url = Uri.parse('${baseURL}api/helpdesk/feedback/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'response': responseId,
          'feedback_text': feedbackText,
        }),
      );

      if (response.statusCode == 201) {
        // Feedback successfully submitted
        // You can handle any UI updates or feedback to the user here
      } else {
        // Handle errors or display feedback to the user
      }
    } catch (error) {
      // Handle errors or display feedback to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Responses'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text('Failed to load responses.'))
              : ListView.builder(
                  itemCount: issueResponses.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Response: ${issueResponses[index].response}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Submitted On: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(issueResponses[index].replyDate))}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: feedbackController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your feedback',
                                border: OutlineInputBorder(),
                              ),
                              minLines: 3,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                submitFeedback(issueResponses[index].id, feedbackController.text);
                                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TicketListScreen(),
                            ),
                          );
                              },
                              child: const Text('Submit Feedback'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class IssueResponse {
  final String id;
  final String response;
  final String replyDate;

  IssueResponse({required this.id, required this.response, required this.replyDate});

  factory IssueResponse.fromJson(Map<String, dynamic> json) {
    return IssueResponse(
      id: json['id'],
      response: json['response'],
      replyDate: json['reply_date'],
    );
  }
}
