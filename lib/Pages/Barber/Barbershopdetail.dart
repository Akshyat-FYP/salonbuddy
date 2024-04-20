import 'package:flutter/material.dart';
import 'package:salonbuddy/Pages/Barber/Styleofcut.dart';
import 'package:salonbuddy/Pages/Barber/UpdateBarbershopPage.dart';
import 'package:salonbuddy/Pages/Barber/appointment.dart';
import 'package:salonbuddy/Pages/Barber/barberpage.dart'; // Import the BarberPage

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
        title: Text(
          'Barbershop Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Barbershop Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StyleOfCutPage(
                      barbershopId: barbershopId,
                      accessToken: accessToken,
                    ),
                  ),
                );
              },
              child: Text('Navigate to Style of Cut Page'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentsPage(
                      barbershopId: barbershopId,
                      accessToken: accessToken,
                    ),
                  ),
                );
              },
              child: Text('View Appointments'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateBarbershopPage(
                      barbershopId: barbershopId,
                      accessToken: accessToken,
                    ),
                  ),
                );
              },
              child: Text('Edit Barbershop'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarberPage(
                      barbershopId: barbershopId,
                      accessToken: accessToken,
                    ),
                  ),
                );
              },
              child: Text('View Barbers'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
