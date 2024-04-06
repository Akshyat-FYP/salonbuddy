import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentsPage extends StatefulWidget {
  final String accessToken;
  final int userId;

  AppointmentsPage({required this.accessToken, required this.userId});

  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<dynamic> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final apiUrl =
          'http://192.168.10.69:8000/api/verified-appointments/${widget.userId}/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          appointments = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      throw Exception('Error fetching appointments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          final DateTime dateTime = DateTime.parse(appointment['date_time']);
          final formattedDateTime =
              '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';

          return ListTile(
            title: Text('Appointment ID: ${appointment['id']}'),
            subtitle: Text('Date and Time: $formattedDateTime'),
          );
        },
      ),
    );
  }
}
