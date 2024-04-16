import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salonbuddy/Pages/auth/ProfileEditPage.dart';
import 'package:salonbuddy/Pages/auth/loginPage.dart';

class ProfilePage extends StatefulWidget {
  final String accessToken;

  ProfilePage({required this.accessToken});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> profileData = {};
  bool isLoading = true;
  String imageUrl = '';

  Future<void> fetchProfileData(String token) async {
    final profileUrl = 'http://192.168.10.69:8000/api/profile/';
    final imageUrl = 'http://192.168.10.69:8000/api/profile/image/';
    try {
      final profileResponse = await http.get(
        Uri.parse(profileUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (profileResponse.statusCode == 200) {
        final profileJson = json.decode(profileResponse.body);
        setState(() {
          profileData = profileJson;
          isLoading = false;
        });

        final imageResponse = await http.get(
          Uri.parse(imageUrl),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (imageResponse.statusCode == 200) {
          final imageJson = json.decode(imageResponse.body);
          final imageUrl = imageJson['url']; // Assuming the key is 'url'
          setState(() {
            this.imageUrl = imageUrl;
          });
        } else {
          print('Failed to fetch image');
        }
      } else {
        print('Failed to fetch profile data');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : profileData.isEmpty
              ? Center(child: Text('No profile data found'))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name: ${profileData['full_name']}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bio: ${profileData['bio']}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10),
                      imageUrl != null && imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              width: 200,
                              height: 200,
                            )
                          : Container(), // Placeholder if image URL is null or empty
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to the profile edit page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileEditPage(
                                      accessToken: widget.accessToken),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
