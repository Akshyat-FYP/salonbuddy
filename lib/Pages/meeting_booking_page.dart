import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class MeetingBookingPage extends StatefulWidget {
  @override
  _MeetingBookingPageState createState() => _MeetingBookingPageState();
}

class _MeetingBookingPageState extends State<MeetingBookingPage> {
  late DateTime _selectedDate;
  late DateTime _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _bookMeeting() {
    // Add logic to handle the meeting booking
    // You can replace this with your own logic
    print('Meeting booked for $_selectedDate at $_selectedTime');

    // Navigate back to the home page
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Meeting'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the home page
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calendar view button
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Selected Date: ${_selectedDate.toLocal()}',
              ),
            ),
            SizedBox(height: 20),
            // Clock view button
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(
                'Selected Time: ${_selectedTime.toLocal().toLocal()}',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookMeeting,
              child: Text('Book Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
