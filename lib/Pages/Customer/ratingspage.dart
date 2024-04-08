import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentRatingPage extends StatefulWidget {
  final String accessToken;
  final int appointmentId;
  final int barbershop;

  const AppointmentRatingPage({
    Key? key,
    required this.accessToken,
    required this.appointmentId,
    required this.barbershop,
  }) : super(key: key);

  @override
  State<AppointmentRatingPage> createState() => _AppointmentRatingPageState();
}

class _AppointmentRatingPageState extends State<AppointmentRatingPage> {
  double _currentRating = 1;
  TextEditingController _commentController = TextEditingController();

  Future<void> updateAppointmentRating(double rating, String? comment) async {
    final url = Uri.parse(
        'http://192.168.10.69:8000/api/barbershops/${widget.barbershop}/appointments/${widget.appointmentId}/');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
        body: jsonEncode({
          'rating': rating,
          'rating_comment': comment,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rating updated successfully!')),
        );
      } else {
        throw Exception('Failed to update rating');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating rating: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Appointment'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Rate your service',
                  style: Theme.of(context).textTheme.headline5),
              RatingBar.builder(
                initialRating: _currentRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentRating = rating;
                  });
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: 'Enter your comment (optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => updateAppointmentRating(
                    _currentRating, _commentController.text),
                child: const Text('Submit Rating'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
