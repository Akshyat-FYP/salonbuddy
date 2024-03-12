import 'package:barberboss/Pages/forget_Password.dart';
import 'package:barberboss/Pages/register.dart';
import 'package:flutter/material.dart';
import 'package:barberboss/Components/My_textfeild.dart';
import 'package:barberboss/Components/my_button.dart';
import 'package:barberboss/Pages/home.dart';

class login extends StatelessWidget {
  login({super.key});
  //text editing controller
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  //sign user in
  void signUserIn(BuildContext context) {
    // Add your authentication logic here

    // Navigate to the second page on successful sign-in
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MyHomePage()), // Replace with the actual name of your second page class
    );
  }

  //Register

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
            // Image(image: AssetImage('images/BarberBoss.png')),
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
                  GestureDetector(
                    onTap: () {
                      // Navigate to the Forgot Password page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            //sign in button
            MyButton(
              onTap: () => signUserIn(context),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the Register page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 50,
            )
            // or continue with
            //google +apple sign in button
            // not a member? register now
          ]),
        ),
      ),
    );
  }
}
