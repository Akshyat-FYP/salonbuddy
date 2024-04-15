import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BarberAppointmentsPage extends StatefulWidget {
  final int barbershopId;
  final String accessToken;

  BarberAppointmentsPage({
    required this.barbershopId,
    required this.accessToken,
  });

  @override
  _BarberAppointmentsPageState createState() => _BarberAppointmentsPageState();
}

class _BarberAppointmentsPageState extends State<BarberAppointmentsPage> {
  List<dynamic> appointments = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final apiUrl =
          'http://192.168.10.69:8000/api/barber-appointments/${widget.barbershopId}/verified/';
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer ${widget.accessToken}'});

      if (response.statusCode == 200) {
        setState(() {
          appointments = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        isLoading = false;
        error = 'Failed to fetch appointments: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barber Appointments'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: generatePdfAndView,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : appointments.isEmpty
                  ? Center(child: Text('No appointments found.'))
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];
                        return ListTile(
                          title: Text('Appointment ID: ${appointment['id']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${appointment['date_time']}'),
                              FutureBuilder<Map<String, dynamic>>(
                                future: fetchBarberName(appointment['barber']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.connectionState ==
                                          ConnectionState.none) {
                                    return Text('Barber: Loading...');
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Barber: Error');
                                  }
                                  return Text(
                                      'Barber: ${snapshot.data?['name'] ?? 'N/A'}');
                                },
                              ),
                              Text(
                                  'Style of Cut: ${appointment['style_of_cut'] ?? 'None'}'),
                              Text('Verified: ${appointment['verified']}'),
                              Text(
                                  'Service Rated: ${appointment['service_rated']}'),
                              Text('Rating: ${appointment['rating']}'),
                              Text(
                                  'Rating Comment: ${appointment['rating_comment'] ?? 'None'}'),
                            ],
                          ),
                        );
                      },
                    ),
    );
  }

  Future<Map<String, dynamic>> fetchBarberName(int barberId) async {
    final apiUrl =
        'http://192.168.10.69:8000/api/barbershop/${widget.barbershopId}/barbers/$barberId';
    final response = await http.get(Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load barber name');
    }
  }

  Future<void> generatePdfAndView() async {
    // Implement the PDF generation logic
  }
}
