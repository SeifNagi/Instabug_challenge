import 'package:flutter/material.dart';
import '../controllers/bug_report_controller.dart';
import '../models/user_feedback_model.dart';

class CustomBugActionsScreen extends StatelessWidget {
  final BugReportController controller = BugReportController();

  CustomBugActionsScreen({super.key});

  void _handleAction(String tag) async {
    final feedback = UserFeedbackModel(
      email: "seif.nagi.kozman@gmail.com",
      attributes: {
        "user_id": "JD9876",
        "plan": "enterprise",
        "region": "EU",
      },
      tags: ["session_tag", tag],
    );

    await controller.submitFeedback(feedback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Need Help?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.bug_report),
              label: const Text('Report a problem'),
              onPressed: () => _handleAction("Bug"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.announcement),
              label: const Text('Suggest an improvement'),
              onPressed: () => _handleAction("Improvement"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.question_mark),
              label: const Text('Ask a question'),
              onPressed: () => _handleAction("Question"),
            ),
          ],
        ),
      ),
    );
  }
}
