import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';

class ProfileEditPage extends StatefulWidget {
  final String accessToken;

  const ProfileEditPage({Key? key, required this.accessToken})
      : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _bioController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePickerAndroid().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    final apiUrl = 'http://192.168.10.69:8000/api/profile/update/';
    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${widget.accessToken}',
    };

    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
    request.headers.addAll(headers);

    // Add form fields
    request.fields['full_name'] = _fullNameController.text;
    request.fields['bio'] = _bioController.text;

    // Add image file
    if (_image != null) {
      var image = await http.MultipartFile.fromPath('image', _image!.path);
      request.files.add(image);
    }

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      // Profile updated successfully
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile updated')));
      // Navigate back to the previous page
      Navigator.pop(context);
    } else {
      // Failed to update profile
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: _updateProfile,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Choose Image'),
            ),
            SizedBox(height: 20),
            if (_image != null) ...[
              Image.file(_image!),
              SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
