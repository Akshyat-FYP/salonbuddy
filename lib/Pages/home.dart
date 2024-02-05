import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homepageState();
}

class _homepageState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            //hello again
            Text(
              'Hello Again',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome back You\'ve been missed',
              style: TextStyle(fontSize: 20),
            ),

            // Email textfield
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white)),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

            //password textfiekd
            //sigb in bytton
            //not a member> register now
          ]),
        ),
      ),
    );
  }
}
