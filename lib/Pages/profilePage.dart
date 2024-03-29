// profile_page.dart
import 'package:flutter/material.dart';
import 'package:barberboss/widgets/horizontal_line.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulating user data
    final Map<String, dynamic> user = {
      'displayName': 'John Doe',
      'email': 'johndoe@example.com',
      'photoURL': 'https://via.placeholder.com/150', // Placeholder image URL
    };

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Profile",
                style: TextStyle(
                  color: Color(0xff721c80),
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 12.0),
              const HorizontalLine(),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(user['photoURL'] ?? ''),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['displayName'] ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user['email'] ?? '',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              const SectionCard(
                header: "My orders",
                desc: "Already have 12 orders",
              ),
              const SectionCard(
                header: "Shipping address",
                desc:
                    "Robert Robertson, 1234 NW Bobcat Lane, St. Robert, MO 65584-5678.",
              ),
              const SectionCard(
                header: "Payments method",
                desc: "Visa **34",
              ),
              const SectionCard(
                header: "Promocodes",
                desc: "You have special offers",
              ),
              const SectionCard(
                header: "My reviews",
                desc: "Reviews for 4 barbers",
              ),
              const SectionCard(
                header: "Settings",
                desc: "Notification, password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String header;
  final String desc;
  const SectionCard({
    Key? key,
    required this.header,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: Color(0xff721c80),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 12),
        const HorizontalLine(),
        const SizedBox(height: 12),
      ],
    );
  }
}
