import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salonbuddy/Pages/Barber/approveappointmentpage.dart';

class AppointmentsPage extends StatefulWidget {
  final int barbershopId;
  final String accessToken;

  AppointmentsPage({
    required this.barbershopId,
    required this.accessToken,
  });

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
          'http://192.168.10.69:8000/api/barbershops/${widget.barbershopId}/appointments/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          appointments = json.decode(response.body);
        });
      } else {
        throw Exception(
            'Failed to load appointments. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      throw Exception('Error fetching appointments');
    }
  }

  Future<dynamic> fetchCustomer(int customerId) async {
    final apiUrl = 'http://192.168.10.69:8000/api/users/$customerId/';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer ${widget.accessToken}'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load customer details. Status Code: ${response.statusCode}');
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

          return FutureBuilder(
            future: fetchCustomer(appointment['customer']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final customer = snapshot.data;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApproveAppointmentPage(
                          barbershopId: widget.barbershopId,
                          appointmentId: appointment['id'],
                          accessToken: widget.accessToken,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Appointment ID: ${appointment['id']}'),
                    subtitle: Text(
                        'Date and Time: $formattedDateTime\nCustomer: ${customer['username']}'),
                    // Add more details as needed
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}