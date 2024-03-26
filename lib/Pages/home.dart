import 'package:barberboss/Pages/booking_page.dart';
import 'package:barberboss/Pages/books.dart';
import 'package:barberboss/Pages/couponPage.dart';
import 'package:barberboss/Pages/login_page.dart';
import 'package:barberboss/Pages/map.dart';
import 'package:barberboss/Pages/meeting_booking_page.dart';
import 'package:barberboss/Pages/profilePage.dart';
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
    MapsPage(),
    BookingScreen(),
    CouponPage(),
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
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
                  icon: Icon(Icons.event),
                  label: 'Meeting',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard),
                  label: 'Coupon',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
