import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salonbuddy/Pages/Barber/createbarberpage.dart';

class BarberPage extends StatefulWidget {
  final int barbershopId;
  final String accessToken;

  BarberPage({
    required this.barbershopId,
    required this.accessToken,
  });

  @override
  _BarberPageState createState() => _BarberPageState();
}

class _BarberPageState extends State<BarberPage> {
  List<dynamic> barbers = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchBarbers();
  }

  Future<void> fetchBarbers() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final apiUrl =
          'http://192.168.10.69:8000/api/barbershop/${widget.barbershopId}/barbers/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          barbers = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load barbers');
      }
    } catch (e) {
      print('Error fetching barbers: $e');
      setState(() {
        isLoading = false;
        error = 'Failed to fetch barbers: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbers'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : barbers.isEmpty
                  ? Center(child: Text('No barbers found.'))
                  : ListView.builder(
                      itemCount: barbers.length,
                      itemBuilder: (context, index) {
                        final barber = barbers[index];
                        return ListTile(
                          title: Text('Barber ID: ${barber['id']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${barber['name']}'),
                              Text('Phone: ${barber['phone_number']}'),
                              Text('Address: ${barber['address']}'),
                            ],
                          ),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateBarberPage(
                barbershopId: widget.barbershopId,
                accessToken: widget.accessToken,
              ),
            ),
          ).then((_) {
            fetchBarbers(); // Refresh the list of barbers after creating a new one
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
