import 'package:flutter/material.dart';
import 'package:han/Components/My_textfeild.dart';
import 'package:han/Components/my_button.dart';

class login extends StatelessWidget {
  login({super.key});
  //text editing controller
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            //logo
            const Icon(
              Icons.lock,
              size: 100,
            ),

            const SizedBox(height: 50),
            //welcome back you've been missed
            Text(
              "Welcome back you've been missed!",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            //username textfield
            MyTextFeild(
              controller: usernamecontroller,
              hintText: "Username",
              obscureText: false,
            ),
            //password textfield
            const SizedBox(height: 25),
            MyTextFeild(
              controller: passwordcontroller,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 25),
            // forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            //sign in button
            MyButton(),
            // or continue with
            //google +apple sign in button
            // not a member? register now
          ]),
        ),
      ),
    );
  }
}
