import 'package:flutter/material.dart';
import 'package:tugasku/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugasku',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 196, 35, 218)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}


