import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salonbuddy/Pages/auth/loginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String _selectedRole = 'customer'; // Default role

  String _usernameError = '';
  String _emailError = '';
  String _passwordError = '';
  String _confirmPasswordError = '';
  String _phoneError = '';
  String _addressError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: _usernameError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _usernameError = value.isEmpty ? 'Username is required' : '';
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _emailError = value.isEmpty ? 'Email is required' : '';
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _passwordError = value.isEmpty ? 'Password is required' : '';
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: _confirmPasswordError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _confirmPasswordError =
                      value.isEmpty ? 'Confirm password is required' : '';
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                errorText: _phoneError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _phoneError = value.isEmpty ? 'Phone is required' : '';
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                errorText: _addressError,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _addressError = value.isEmpty ? 'Address is required' : '';
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: ['customer', 'barber', 'admin']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Role',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text.trim().isEmpty) {
                  setState(() {
                    _usernameError = 'Username is required';
                  });
                }
                if (_emailController.text.trim().isEmpty) {
                  setState(() {
                    _emailError = 'Email is required';
                  });
                }
                if (_passwordController.text.trim().isEmpty) {
                  setState(() {
                    _passwordError = 'Password is required';
                  });
                }
                if (_confirmPasswordController.text.trim().isEmpty) {
                  setState(() {
                    _confirmPasswordError = 'Confirm password is required';
                  });
                }
                if (_phoneController.text.trim().isEmpty) {
                  setState(() {
                    _phoneError = 'Phone is required';
                  });
                }
                if (_addressController.text.trim().isEmpty) {
                  setState(() {
                    _addressError = 'Address is required';
                  });
                }
                if (_usernameController.text.trim().isNotEmpty &&
                    _emailController.text.trim().isNotEmpty &&
                    _passwordController.text.trim().isNotEmpty &&
                    _confirmPasswordController.text.trim().isNotEmpty &&
                    _phoneController.text.trim().isNotEmpty &&
                    _addressController.text.trim().isNotEmpty) {
                  _register(context);
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
    // Construct the JSON payload including the selected role
    final Map<String, dynamic> requestBody = {
      'username': _usernameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'password2': _confirmPasswordController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
      'role': _selectedRole, // Include the selected role here
    };

    final String apiUrl = 'http://192.168.10.69:8000/api/register/';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      // Registration successful
      // Navigate to login page or any other destination
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Registration failed
      // Parse error message from response and display
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String errorMessage = responseData['message'];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
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
    }
  }
}
