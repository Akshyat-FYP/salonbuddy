// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
