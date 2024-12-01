// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:chat_app/Screens/chat_page.dart';
import 'package:chat_app/Screens/login_page.dart';
import 'package:chat_app/Screens/register_page.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define app routes
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      // Theme customization
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        focusColor: Colors.blue,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      // Set the initial route
      initialRoute: LoginPage.id,
      // Fallback for unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      },
    );
  }
}
