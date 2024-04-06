import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class CreateAppointmentPage extends StatefulWidget {
  final int barbershopId;
  final String accessToken;

  CreateAppointmentPage({
    required this.barbershopId,
    required this.accessToken,
  });

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController styleOfCutController = TextEditingController();
  String? selectedStyleOfCut;
  List<dynamic> stylesOfCut = [];

  @override
  void initState() {
    super.initState();
    fetchStylesOfCut();
  }

  Future<void> fetchStylesOfCut() async {
    try {
      final apiUrl =
          'http://192.168.10.69:8000/api/barbershops/${widget.barbershopId}/styles_of_cut/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          stylesOfCut = json.decode(response.body);
        });
      } else {
        throw Exception(
            'Failed to load styles of cut. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching styles of cut: $e');
      throw Exception('Error fetching styles of cut');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  Future<void> createAppointment() async {
    final apiUrl =
        'http://192.168.10.69:8000/api/barbershops/${widget.barbershopId}/appointments/create/';

    // Decode the access token to extract the user ID
    final Map<String, dynamic> payload = Jwt.parseJwt(widget.accessToken);
    final int userId = payload['user_id'];

    final Map<String, dynamic> appointmentData = {
      'barbershop': widget.barbershopId,
      'customer': userId, // Use the user ID extracted from the access token
      'style_of_cut': selectedStyleOfCut,
      'date_time': DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedTime.hour, selectedTime.minute)
          .toString(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode(appointmentData),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        throw Exception(
            'Failed to create appointment. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating appointment: $e');
      // Handle error, show a snackbar, toast, or dialog to inform the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(selectedDate.toString().split(' ')[0]),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                _selectTime(context);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Time',
                  hintText: 'Select Time',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(selectedTime.format(context)),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedStyleOfCut,
              onChanged: (newValue) {
                setState(() {
                  selectedStyleOfCut = newValue;
                });
              },
              items: stylesOfCut.map<DropdownMenuItem<String>>((style) {
                return DropdownMenuItem<String>(
                  value: style['name'],
                  child: Text(style['name']),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Style of Cut',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                createAppointment();
              },
              child: Text('Create Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
