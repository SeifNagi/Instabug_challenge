class UserFeedbackModel {
  final String email;
  final Map<String, String> attributes;
  final List<String> tags;

  UserFeedbackModel({
    required this.email,
    required this.attributes,
    required this.tags,
  });
}
