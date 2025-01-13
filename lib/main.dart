import 'package:flutter/material.dart';
import 'package:qrgcode/screens/timepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Timepage(),
      title: 'Qr Gcode',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF064635),
          fontFamily: 'Quicksand'),
      debugShowCheckedModeBanner: false,
    );
  }
}
