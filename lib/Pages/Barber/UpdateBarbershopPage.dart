import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateBarbershopPage extends StatefulWidget {
  final int barbershopId;
  final String accessToken;

  UpdateBarbershopPage({
    required this.barbershopId,
    required this.accessToken,
  });

  @override
  _UpdateBarbershopPageState createState() => _UpdateBarbershopPageState();
}

class _UpdateBarbershopPageState extends State<UpdateBarbershopPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController inServiceController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBarbershopDetails();
  }

  Future<void> fetchBarbershopDetails() async {
    try {
      final apiUrl =
          'http://192.168.10.69:8000/api/barbershops/${widget.barbershopId}/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nameController.text = data['name'];
          addressController.text = data['address'];
          inServiceController.text = data['in_service'].toString();
        });
      } else {
        throw Exception(
            'Failed to load barbershop details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching barbershop details: $e');
    }
  }

  Future<void> updateBarbershop() async {
    setState(() {
      isLoading = true;
    });

    final apiUrl =
        'http://192.168.10.69:8000/api/barbershops/${widget.barbershopId}/';
    final Map<String, dynamic> updatedData = {
      'name': nameController.text,
      'address': addressController.text,
      'in_service': inServiceController.text == 'true',
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        // Barbershop updated successfully
        Navigator.pop(context, true); // Navigate back with success status
      } else {
        throw Exception(
            'Failed to update barbershop. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating barbershop: $e');
      // Handle error
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Barbershop'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: inServiceController,
              decoration: InputDecoration(labelText: 'In Service (true/false)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                updateBarbershop();
              },
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Update Barbershop'),
            ),
          ],
        ),
      ),
    );
  }
}
