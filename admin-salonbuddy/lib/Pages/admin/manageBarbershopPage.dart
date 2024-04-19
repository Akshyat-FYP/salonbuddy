import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salonbuddy/Pages/Barber/Barbershopdetail.dart';

class ManageBarbershopPage extends StatelessWidget {
  final String accessToken;

  ManageBarbershopPage({required this.accessToken});

  Future<List<Map<String, dynamic>>> _fetchBarbershops() async {
    final response = await http.get(
      Uri.parse('http://192.168.10.69:8000/api/barbershops/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load barbershops');
    }
  }

  Future<Map<String, dynamic>> _fetchUser(int userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.10.69:8000/api/users/$userId/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Barbershop'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchBarbershops(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> barbershops = snapshot.data!;
            return ListView.builder(
              itemCount: barbershops.length,
              itemBuilder: (context, index) {
                final barbershop = barbershops[index];
                final int userId = barbershop['user_id'];
                late Future<Map<String, dynamic>> userFuture =
                    _fetchUser(userId);

                return FutureBuilder<Map<String, dynamic>>(
                  future: userFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(title: Text('Loading...'));
                    } else if (snapshot.hasError) {
                      return ListTile(title: Text('Error: ${snapshot.error}'));
                    } else {
                      final user = snapshot.data!;
                      return ListTile(
                        title: Text(barbershop['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(barbershop['address']),
                            SizedBox(height: 4),
                            Text('Owner: ${user['username']}'),
                          ],
                        ),
                        onTap: () {
                          // Navigate to the specific barbershop page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BarbershopDetailsPage(
                                barbershopId: barbershop['id'],
                                accessToken: accessToken,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
