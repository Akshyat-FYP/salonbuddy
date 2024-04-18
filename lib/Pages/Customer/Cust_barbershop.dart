import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salonbuddy/Pages/Customer/CreateAppointment.dart'; // Import your create appointment page

class BarbershopDetailsPage extends StatefulWidget {
  final int barbershopId;
  final String accessToken;

  BarbershopDetailsPage({
    required this.barbershopId,
    required this.accessToken,
  });

  @override
  _BarbershopDetailsPageState createState() => _BarbershopDetailsPageState();
}

class _BarbershopDetailsPageState extends State<BarbershopDetailsPage> {
  late Future<String?> _phoneNumberFuture;

  @override
  void initState() {
    super.initState();
    _phoneNumberFuture = _getUserPhoneNumber(widget.barbershopId);
  }

  Future<String?> _getUserPhoneNumber(int barbershopId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.10.69:8000/api/barbershops/$barbershopId'),
      );
      if (response.statusCode == 200) {
        final userId = json.decode(response.body)['user_id'];
        final userResponse = await http.get(
          Uri.parse('http://192.168.10.69:8000/api/users/$userId'),
        );
        if (userResponse.statusCode == 200) {
          return json.decode(userResponse.body)['phone'];
        } else {
          print('Failed to fetch phone number');
          return null;
        }
      } else {
        print('Failed to fetch user ID');
        return null;
      }
    } catch (e) {
      print('Error fetching phone number: $e');
      return null;
    }
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    if (phoneNumber.isNotEmpty) {
      if (await canLaunch('tel:$phoneNumber')) {
        await launch('tel:$phoneNumber');
      } else {
        print('Cannot launch phone app');
      }
    } else {
      print('Phone number is null or empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbershop Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Barbershop Details'),
            SizedBox(height: 20),
            FutureBuilder<String?>(
              future: _phoneNumberFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final phoneNumber = snapshot.data;
                  return ElevatedButton(
                    onPressed: () => launch("tel://$phoneNumber"),
                    child: Text('Call Barbershop'),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAppointmentPage(
                      barbershopId: widget.barbershopId,
                      accessToken: widget.accessToken,
                    ),
                  ),
                );
              },
              child: Text('Create Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
