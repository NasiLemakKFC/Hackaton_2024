import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_project/Page/homepage.dart';
import 'package:hackaton_project/mainpage.dart';

class SetUserInfo extends StatefulWidget {
  const SetUserInfo({super.key});

  @override
  State<SetUserInfo> createState() => _SetUserInfoState();
}

class _SetUserInfoState extends State<SetUserInfo> {
  final _nickName = TextEditingController();
  final _userAge = TextEditingController();
  final _phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Method to register user information into Firestore
  Future<void> _registerUserInfo() async {
    try {
      // Check if all fields are filled
      if (_nickName.text.trim().isEmpty ||
          _userAge.text.trim().isEmpty ||
          _phoneNumber.text.trim().isEmpty) {
        // Show an error message and return
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      // Add user info to 'User' collection in Firestore
      final data = await FirebaseFirestore.instance.collection('User').add({
        'Nickname': _nickName.text.trim(),
        'Age': _userAge.text.trim(),
        'Phone Number': _phoneNumber.text.trim(),
        'email': FirebaseAuth.instance.currentUser!.email,
      });
      print(data.id);

      // Navigate to Mainpage after successful registration
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Mainpage(),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build UI for user info input
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nickName,
                decoration: InputDecoration(
                  labelText: 'NickName',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _userAge,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneNumber,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _registerUserInfo();
                },
                child: Text('Proceed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}