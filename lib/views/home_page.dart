import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'custom_bug_actions_screen.dart';

class BugReportHomePage extends StatefulWidget {
  const BugReportHomePage({super.key});

  @override
  State<BugReportHomePage> createState() => _BugReportHomePageState();
}

class _BugReportHomePageState extends State<BugReportHomePage> {
  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: (event) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CustomBugActionsScreen()),
        );
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
