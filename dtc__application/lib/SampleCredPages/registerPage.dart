import 'package:dtc__application/api/api.dart';
import 'package:dtc__application/SampleCredPages/loginPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> registerUser() async {
    final success = await Api.registerUser(username.text, password.text);

    if (success) {
      Navigator.pushReplacementNamed(context, "Home");
    } else {
      // Handle registration failure
      print('Registration failed');
      // Show an error message or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 74, 71, 71),
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  labelText: "Enter password",
                  hintText: "password goes here..",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: registerUser,
                child: const Center(
                  child: Text("Register"),
                )),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text(
                "Want to SignUp? click here",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 13, 131)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
