import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salonbuddy/Pages/Customer/Cust_barbershop.dart';
import 'package:salonbuddy/Pages/auth/loginPage.dart';

class BarbershopListPage extends StatefulWidget {
  final String accessToken;

  BarbershopListPage({required this.accessToken});

  @override
  _BarbershopListPageState createState() => _BarbershopListPageState();
}

class _BarbershopListPageState extends State<BarbershopListPage> {
  List<dynamic> barbershops = [];

  @override
  void initState() {
    super.initState();
    fetchBarbershops();
  }

  Future<void> fetchBarbershops() async {
    try {
      final apiUrl = 'http://192.168.10.69:8000/api/barbershops/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          barbershops = json.decode(response.body);
        });
      } else {
        throw Exception(
            'Failed to load barbershops. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching barbershops: $e');
      throw Exception('Error fetching barbershops');
    }
  }

  void navigateToBarbershopDetailsPage(
      BuildContext context, dynamic barbershop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarbershopDetailsPage(
          barbershopId: barbershop['id'],
          accessToken: widget.accessToken,
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbershops'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Barbershops',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: barbershops.length,
                itemBuilder: (context, index) {
                  final barbershop = barbershops[index];
                  return ListTile(
                    title: Text(barbershop['name']),
                    subtitle: Text(barbershop['address']),
                    onTap: () {
                      navigateToBarbershopDetailsPage(context, barbershop);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
