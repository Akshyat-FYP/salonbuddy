import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height:50 ,)
            //logo
            Icon(
              Icons.lock,
              size: 100,
            ),

            SizedBox(height:50),
            //welcome back you've been missed

            //username textfield
            //password textfield
            // forgot password?
            //sign in button
            // or continue with
            //google +apple sign in button
            // not a member? register now
          ]),
        ),
      ),
    );
  }
}
