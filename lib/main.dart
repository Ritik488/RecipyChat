import 'package:flutter/material.dart';
import 'package:recipychat/Screens/Login.dart';
import 'package:recipychat/Screens/Signup.dart';
import 'package:recipychat/Screens/WelcomeScreen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipy Chatter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'Welcome',
      routes: {
        'Welcome': (context) => Welcome(),
        'Login_Screen': (context) => LoginScreen(),
        'Signup_Screen': (context) => SignupScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
