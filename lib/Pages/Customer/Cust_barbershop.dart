import 'package:flutter/material.dart';
import 'package:salonbuddy/Pages/Customer/CreateAppointment.dart'; // Import your create appointment page

class BarbershopDetailsPage extends StatelessWidget {
  final int barbershopId;
  final String accessToken;

  BarbershopDetailsPage({
    required this.barbershopId,
    required this.accessToken,
  });

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
            ElevatedButton(
              onPressed: () {
                // Navigate to the create appointment page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAppointmentPage(
                      barbershopId: barbershopId,
                      accessToken: accessToken,
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
