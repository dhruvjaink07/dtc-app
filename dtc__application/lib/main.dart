import 'dart:io';

import 'package:dtc__application/aboutpage.dart';
import 'package:dtc__application/blogspage.dart';
import 'package:dtc__application/connectpage.dart';
import 'package:dtc__application/eventspage.dart';
import 'package:dtc__application/faqpage.dart';
import 'package:dtc__application/homepage.dart';
import 'package:dtc__application/SampleCredPages/loginPage.dart';
import 'package:dtc__application/SampleCredPages/registerPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final int serverPort;
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "Login",
      routes: {
        "Login": (context) => LoginPage(),
        "Register": (context) => RegisterPage(),
        "Home": (context) => Homepage(),
        "Connect": (context) => ConnectPage(),
        "About": (context) => AboutPage(),
        "Blogs": (context) => BlogsPage(),
        "Events": (context) => Events(),
        "FAQ": (context) => FAQPage(),
      },
    );
  }
}
