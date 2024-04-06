import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:salonbuddy/Pages/Customer/C_appointment.dart';
import 'package:salonbuddy/Pages/Customer/barbershoplist.dart';
import 'package:salonbuddy/Pages/auth/Profile.dart';
import 'package:salonbuddy/Pages/auth/loginPage.dart';

class ChomePage extends StatelessWidget {
  final String accessToken;

  ChomePage({required this.accessToken});

  @override
  Widget build(BuildContext context) {
    // Decode the access token to extract the user ID
    final Map<String, dynamic> tokenPayload = Jwt.parseJwt(accessToken);
    final int userId = tokenPayload['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Customer Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(accessToken: accessToken),
                  ),
                );
              },
              child: Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the BarbershopListPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BarbershopListPage(accessToken: accessToken),
                  ),
                );
              },
              child: Text('View Barbershops'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the AppointmentsPage with user ID passed as argument
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentsPage(
                        userId: userId, accessToken: accessToken),
                  ),
                );
              },
              child: Text('View Appointments'),
            ),
            ElevatedButton(
              onPressed: () {
                // Logout and navigate back to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
