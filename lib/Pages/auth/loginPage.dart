import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salonbuddy/Pages/Barber/bhomepage.dart';
import 'package:salonbuddy/Pages/Customer/chomepage.dart';
import 'package:salonbuddy/Pages/admin/ahomepage.dart';
import 'package:salonbuddy/Pages/auth/forget_Password.dart';
import 'package:salonbuddy/Pages/auth/register.dart';
import 'package:salonbuddy/notification_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String apiUrl = 'http://192.168.10.69:8000/api/token/';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String accessToken = responseData['access'];

      // Decode the access token to get the payload
      final Map<String, dynamic> payload = json.decode(
        utf8.decode(
          base64.decode(base64.normalize(accessToken.split(".")[1])),
        ),
      );

      // Extract the role from the payload
      final String role = payload['role'];

      // Check if the user's role meets the criteria for login
      if (role == 'customer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChomePage(accessToken: accessToken),
          ),
        );
      } else if (role == 'barber') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BHomePage(accessToken: accessToken),
          ),
        );
      } else if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AHomePage(accessToken: accessToken),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('You do not have permission to log in.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }

      // After successful login, send device token to backend
      await sendDeviceTokenToBackend(accessToken);
    } else {
      // Handle error
      final dynamic responseData = json.decode(response.body);
      final String? errorMessage = responseData['detail'];
      if (errorMessage != null) {
        // Display error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // If error message is null, display a generic error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('An unknown error occurred.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      print('Login failed');
    }
  }

  Future<void> sendDeviceTokenToBackend(String accessToken) async {
    // Get the device token
    String? deviceToken = await NotificationService.getDeviceToken();

    // If device token is available, send it to the backend
    if (deviceToken != null) {
      final String apiUrl =
          'http://192.168.10.69:8000/api/update-device-token/';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({'device_token': deviceToken}),
      );

      if (response.statusCode == 200) {
        print('Device token sent to backend successfully');
      } else {
        print('Failed to send device token to backend');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Whitish background color
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 100,
                  color: const Color.fromARGB(
                      255, 0, 0, 0), // Icon color changed to blue
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: const Color.fromARGB(
                        255, 0, 0, 0), // Text color changed to blue
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Colors.grey[600]), // Hint text color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                BorderSide(color: Colors.blue), // Border color
                          ),
                          filled: true,
                          fillColor:
                              Colors.white, // Text field background color
                        ),
                        style: TextStyle(color: Colors.black), // Text color
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.grey[600]), // Hint text color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                BorderSide(color: Colors.blue), // Border color
                          ),
                          filled: true,
                          fillColor:
                              Colors.white, // Text field background color
                        ),
                        style: TextStyle(color: Colors.black), // Text color
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 138, 130, 122),
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _login(context),
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ), // Button color changed to blue
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 146, 132,
                                132), // Link color changed to blue
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
