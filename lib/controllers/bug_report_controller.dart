import 'dart:io';
import 'dart:typed_data';
import 'package:helloworld/models/user_feedback_model.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class BugReportController {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> submitFeedback(UserFeedbackModel feedback) async {
    //take user email and attributes
    await Instabug.identifyUser(feedback.email);
    await Instabug.appendTags(feedback.tags);

    //add user attributes
    for (final entry in feedback.attributes.entries) {
      await Instabug.setUserAttribute(entry.key, entry.value);
    }

    //add debug log file
    final Directory tempDir = await getTemporaryDirectory();
    final File logFile = File('${tempDir.path}/instabug_log.txt');
    await logFile.writeAsString("INFO: Bug screen opened\nERROR: Mock error\n");
    final Uint8List logFileBytes = await logFile.readAsBytes();
    await Instabug.addFileAttachmentWithData(logFileBytes, "Debug log file");

    final Uint8List? screenshot = await screenshotController.capture();
    if (screenshot != null) {
      await Instabug.addFileAttachmentWithData(screenshot, "App Screenshot");
    }

    await Instabug.show();
  }

  Future<void> handleAction(String tag) async {
    final feedback = UserFeedbackModel(
      email: "seif.nagi.kozman@gmail.com",
      attributes: {
        "user_id": "JD9876",
        "plan": "enterprise",
        "region": "EU",
      },
      tags: ["session_tag", tag],
    );

    await submitFeedback(feedback);
  }
}
