import 'package:flutter/material.dart';
import 'package:omni/screens/home_screen.dart';

import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omni',
        debugShowCheckedModeBanner: false,
      home:HomeScreen(),
    );
  }
}
