import 'package:flutter/material.dart';
import 'package:barberboss/Components/date_picker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedIndex = 0;

  void onClick(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff721c80),
                    Color.fromARGB(255, 196, 103, 169),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 38, left: 18, right: 18),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Spacer(),
                        Text(
                          "Book Your Appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    const CustomDatePicker(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Slots",
                    style: TextStyle(
                      color: Color.fromARGB(255, 45, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(),
                          ),
                          label: const Text("10:00 AM"),
                          backgroundColor: Colors.white,
                        ),
                        Chip(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(),
                          ),
                          label: const Text(
                            "10:00 AM",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.purple,
                        ),
                        Chip(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(),
                          ),
                          label: const Text("10:00 AM"),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  ChipWrapper(),
                  ChipWrapper(),
                  ChipWrapper(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Select Services",
                    style: TextStyle(
                      color: Color.fromARGB(255, 45, 42, 42),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Placeholder for service selection UI
                ],
              ),
            ),
            GestureDetector(
              onTap: (() {
                // Placeholder for booking functionality
              }),
              child: Container(
                margin: const EdgeInsets.only(left: 18, right: 18),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff721c80),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff721c80),
                      Color.fromARGB(255, 196, 103, 169),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Book an appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipWrapper extends StatelessWidget {
  const ChipWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap with SingleChildScrollView
      scrollDirection: Axis.horizontal, // Set the scrolling direction
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Chip(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(),
            ),
            label: const Text("10:00 AM"),
            backgroundColor: Colors.white,
          ),
          Chip(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(),
            ),
            label: const Text("10:00 AM"),
            backgroundColor: Colors.white,
          ),
          Chip(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(),
            ),
            label: const Text("10:00 AM"),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
