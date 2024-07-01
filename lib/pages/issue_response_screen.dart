import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_helpdesk/auth/baseUrl.dart';
import 'package:intl/intl.dart';

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
  final String response;
  final String replyDate;

  IssueResponse({required this.response, required this.replyDate});

  factory IssueResponse.fromJson(Map<String, dynamic> json) {
    return IssueResponse(
      response: json['response'],
      replyDate: json['reply_date'],
    );
  }
}
