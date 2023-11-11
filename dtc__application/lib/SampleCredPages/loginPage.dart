import 'package:dtc__application/api/api.dart';
import 'package:dtc__application/SampleCredPages/registerPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginUser() async {
    final success = await Api.loginUser(username.text, password.text);

    if (success) {
      // Navigate to the home screen or perform other actions
      Navigator.pushReplacementNamed(context, "Home");
    } else {
      // Handle login failure
      print('Login failed');
      // Show an error message or take appropriate action
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
            const Text("Login>>>>", style: TextStyle(fontSize: 30)),
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
                onPressed: loginUser,
                child: const Center(
                  child: Text("Login"),
                )),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
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
