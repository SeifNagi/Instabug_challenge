import 'package:flutter/material.dart';
import 'package:helloworld/controllers/bug_report_controller.dart';
import 'package:shake/shake.dart';

class BugReportHomePage extends StatefulWidget {
  const BugReportHomePage({super.key});
  @override
  State<BugReportHomePage> createState() => _BugReportHomePageState();
}

class _BugReportHomePageState extends State<BugReportHomePage> {
  ShakeDetector? detector;
  final BugReportController bugCtrl = BugReportController();


  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        bugCtrl.handleAction("shake");
      },
    );
  }

  @override
  void dispose() {
    detector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YOUR AWESOME APP')),
      body: const Center(
        child: Text(
          'Shake your device to report a bug!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
