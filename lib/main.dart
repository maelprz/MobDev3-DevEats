import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const DevEatsApp());
}

class DevEatsApp extends StatelessWidget {
  const DevEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevEats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}