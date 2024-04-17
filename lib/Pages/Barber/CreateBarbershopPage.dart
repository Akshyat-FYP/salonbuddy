import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateBarbershopPage extends StatefulWidget {
  final String accessToken;

  CreateBarbershopPage({required this.accessToken});

  @override
  _CreateBarbershopPageState createState() => _CreateBarbershopPageState();
}

class _CreateBarbershopPageState extends State<CreateBarbershopPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;

  Future<void> createBarbershop(BuildContext context) async {
    final int userId = extractUserIdFromToken(widget.accessToken);
    final String apiUrl =
        'http://192.168.10.69:8000/api/barbershops/create/$userId/';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': nameController.text,
        'address': addressController.text,
        'opening_time': openingTime != null
            ? '${openingTime!.hour}:${openingTime!.minute}'
            : null,
        'closing_time': closingTime != null
            ? '${closingTime!.hour}:${closingTime!.minute}'
            : null,
        'user_id': userId, // Pass user ID as a separate field
      }),
    );

    if (response.statusCode == 201) {
      // Barbershop created successfully
      Navigator.pop(context, true); // Pass true back to indicate success
    } else {
      // Show error message if failed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to create barbershop'),
      ));
    }
  }

  int extractUserIdFromToken(String accessToken) {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid access token');
      }
      final payload = parts[1];
      final decodedPayload = base64Url.decode(base64.normalize(payload));
      final Map<String, dynamic> payloadMap =
          json.decode(utf8.decode(decodedPayload));
      return payloadMap['user_id'] ??
          payloadMap['id']; // Try 'user_id' first, fallback to 'id'
    } catch (e) {
      print('Error decoding access token:');
      print('Token: $accessToken');
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> _selectOpeningTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        openingTime = selectedTime;
      });
    }
  }

  Future<void> _selectClosingTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        closingTime = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Barbershop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Opening Time:'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectOpeningTime(context),
                  child: Text(
                    openingTime != null
                        ? '${openingTime!.hour}:${openingTime!.minute}'
                        : 'Select Time',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Closing Time:'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectClosingTime(context),
                  child: Text(
                    closingTime != null
                        ? '${closingTime!.hour}:${closingTime!.minute}'
                        : 'Select Time',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createBarbershop(context);
              },
              child: Text('Create Barbershop'),
            ),
          ],
        ),
      ),
    );
  }
}
