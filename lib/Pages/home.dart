// main.dart
import 'package:barberboss/Pages/CouponPage.dart';
import 'package:barberboss/Pages/ProfilePage.dart';
import 'package:barberboss/Pages/booking_page.dart';
import 'package:barberboss/Pages/login_page.dart';
import 'package:barberboss/Pages/map.dart';
import 'package:barberboss/Pages/meeting_booking_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BookingPage(),
    MapPage(),
    CouponPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add logic to handle logout
              // For now, let's navigate back to the login page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              ); // Replace with your route
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Coupon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Meeting',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 4) {
            // Navigate to MeetingBookingPage when the "Meeting" tab is selected
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeetingBookingPage(),
              ),
            );
          }
        },
      ),
    );
  }
}

// ... (Other pages and LoginPage implementation remain unchanged)
