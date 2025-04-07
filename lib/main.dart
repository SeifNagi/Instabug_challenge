import 'package:flutter/material.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MyApp());

  Instabug.init(
    token: '366d1da2a3efac777d62a6c3f9014bfe',
    invocationEvents: [InvocationEvent.shake],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Shake Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        // Other theme properties
      ),
      debugShowCheckedModeBanner: false,
      home: const BugReportHomePage(),
    );
  }
}
