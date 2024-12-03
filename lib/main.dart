import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/contact_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion des Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContactView(),
    );
  }
}
