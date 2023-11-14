import 'dart:convert';

import 'package:dtc__application/SampleCredPages/loginPage.dart';
import 'package:dtc__application/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> registerUser() async {
    final apiUrl =
        'http://localhost:3000/auth/register'; // Replace with your actual API registration endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'
        }, // Specify JSON content type
        body: jsonEncode({
          'username': username.text,
          'password': password.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successful registration
        print('Registration successful');
        // Navigate to the login screen or perform other actions
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        // Handle registration failure
        print('Registration failed: ${response.body}');
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x252525),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register<<<<<", style: TextStyle(fontSize: 30)),
            TextField(
              controller: username,
              decoration: InputDecoration(
                labelText: "Enter username",
                hintText: "username goes here..",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: "Enter password",
                hintText: "password goes here..",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: const Center(
                child: Text("Register"),
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text(
                "Already have an account? Login here",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 29, 13, 131),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
