import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../models/user_feedback_model.dart';

class BugReportController {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> submitFeedback(UserFeedbackModel feedback) async {
    await Instabug.identifyUser(feedback.email);
    await Instabug.appendTags(feedback.tags);

    for (final entry in feedback.attributes.entries) {
      await Instabug.setUserAttribute(entry.key, entry.value);
    }

    final Directory tempDir = await getTemporaryDirectory();
    final File logFile = File('${tempDir.path}/instabug_log.txt');
    await logFile.writeAsString("INFO: Bug screen opened\nERROR: Mock error\n");
    final Uint8List logFileBytes = await logFile.readAsBytes();
    await Instabug.addFileAttachmentWithData(logFileBytes, "Debug log file");

    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await File(image.path).readAsBytes();
      await Instabug.addFileAttachmentWithData(
          imageBytes, "User-selected image");
    }

    final Uint8List? screenshot = await screenshotController.capture();
    if (screenshot != null) {
      await Instabug.addFileAttachmentWithData(screenshot, "App Screenshot");
    }

    await Instabug.show();
  }
}
