import 'package:flutter/material.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:shake/shake.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:logger/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

final logger = Logger();
ScreenshotController screenshotController = ScreenshotController();

void main() {
  runApp(const MyApp());

  Instabug.init(
    token: '366d1da2a3efac777d62a6c3f9014bfe',
    invocationEvents: [
      InvocationEvent.shake
    ], // Ensure this is correct based on SDK version
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Shake Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BugReportHomePage(),
    );
  }
}

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
      onPhoneShake: (ShakeEvent event) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const CustomBugActionsScreen(),
          ),
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
      appBar: AppBar(
        title: const Text('Shake Demo Home'),
      ),
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

class CustomBugActionsScreen extends StatelessWidget {
  const CustomBugActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How can we help?')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.bug_report),
              label: const Text('Report a problem'),
              onPressed: () async {
                logger.i("User opened feedback screen");
                logger.e("Error loading user profile");

                String userEmail = "seif.nagi.kozman@gmail.com";
                Map<String, String> userAttributes = {
                  "user_id": "JD9876",
                  "plan": "enterprise",
                  "region": "EU",
                };

                await Instabug.identifyUser(userEmail);
                await Instabug.appendTags(["session_tag", "Bug"]);

                for (final entry in userAttributes.entries) {
                  await Instabug.setUserAttribute(entry.key, entry.value);
                }

                // Attach log file
                final Directory tempDir = await getTemporaryDirectory();

// Create the log file in the temporary directory
                final File logFile = File('${tempDir.path}/instabug_log.txt');

// Write some mock log data
                await logFile.writeAsString(
                    "INFO: Bug screen opened\nERROR: Mock error\n");

// Read the log file as bytes (Uint8List)
                final Uint8List logFileBytes = await logFile.readAsBytes();

// Attach the log file to Instabug using the file bytes (Uint8List)
                await Instabug.addFileAttachmentWithData(
                    logFileBytes, "Debug log file");

                // Pick image from gallery
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  // Read the image file as bytes (Uint8List)
                  final File file = File(image.path);
                  final Uint8List fileBytes = await file.readAsBytes();

                  // Attach the image file to Instabug with the file bytes
                  await Instabug.addFileAttachmentWithData(
                      fileBytes, "User-selected image");
                }
                screenshotController
                    .capture()
                    .then((Uint8List? screenshotBytes) async {
                  if (screenshotBytes != null) {
                    await Instabug.addFileAttachmentWithData(
                        screenshotBytes, "App Screenshot");
                  }
                });
                await Instabug.show();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.lightbulb),
              label: const Text('Suggest an improvement'),
              onPressed: () async {
                logger.i("User opened feedback screen");
                logger.e("Error loading user profile");

                String userEmail = "seif.nagi.kozman@gmail.com";
                Map<String, String> userAttributes = {
                  "user_id": "JD9876",
                  "plan": "enterprise",
                  "region": "EU",
                };

                await Instabug.identifyUser(userEmail);
                await Instabug.appendTags(["session_tag", "Improvment"]);

                for (final entry in userAttributes.entries) {
                  await Instabug.setUserAttribute(entry.key, entry.value);
                }

                // Attach log file
                final Directory tempDir = await getTemporaryDirectory();

// Create the log file in the temporary directory
                final File logFile = File('${tempDir.path}/instabug_log.txt');

// Write some mock log data
                await logFile.writeAsString(
                    "INFO: Bug screen opened\nERROR: Mock error\n");

// Read the log file as bytes (Uint8List)
                final Uint8List logFileBytes = await logFile.readAsBytes();

// Attach the log file to Instabug using the file bytes (Uint8List)
                await Instabug.addFileAttachmentWithData(
                    logFileBytes, "Debug log file");

                // Pick image from gallery
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  // Read the image file as bytes (Uint8List)
                  final File file = File(image.path);
                  final Uint8List fileBytes = await file.readAsBytes();

                  // Attach the image file to Instabug with the file bytes
                  await Instabug.addFileAttachmentWithData(
                      fileBytes, "User-selected image");
                }
                screenshotController
                    .capture()
                    .then((Uint8List? screenshotBytes) async {
                  if (screenshotBytes != null) {
                    await Instabug.addFileAttachmentWithData(
                        screenshotBytes, "App Screenshot");
                  }
                });
                await Instabug.show();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.question_answer),
              label: const Text('Ask a question'),
              onPressed: () async {
                logger.i("User opened feedback screen");
                logger.e("Error loading user profile");

                String userEmail = "seif.nagi.kozman@gmail.com";
                Map<String, String> userAttributes = {
                  "user_id": "JD9876",
                  "plan": "enterprise",
                  "region": "EU",
                };

                await Instabug.identifyUser(userEmail);
                await Instabug.appendTags(["session_tag", "Question"]);

                for (final entry in userAttributes.entries) {
                  await Instabug.setUserAttribute(entry.key, entry.value);
                }

                // Attach log file
                final Directory tempDir = await getTemporaryDirectory();

// Create the log file in the temporary directory
                final File logFile = File('${tempDir.path}/instabug_log.txt');

// Write some mock log data
                await logFile.writeAsString(
                    "INFO: Bug screen opened\nERROR: Mock error\n");

// Read the log file as bytes (Uint8List)
                final Uint8List logFileBytes = await logFile.readAsBytes();

// Attach the log file to Instabug using the file bytes (Uint8List)
                await Instabug.addFileAttachmentWithData(
                    logFileBytes, "Debug log file");

                // Pick image from gallery
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  // Read the image file as bytes (Uint8List)
                  final File file = File(image.path);
                  final Uint8List fileBytes = await file.readAsBytes();

                  // Attach the image file to Instabug with the file bytes
                  await Instabug.addFileAttachmentWithData(
                      fileBytes, "User-selected image");
                }
                screenshotController
                    .capture()
                    .then((Uint8List? screenshotBytes) async {
                  if (screenshotBytes != null) {
                    await Instabug.addFileAttachmentWithData(
                        screenshotBytes, "App Screenshot");
                  }
                });
                await Instabug.show();
              },
            ),
          ],
        ),
      ),
    );
  }
}