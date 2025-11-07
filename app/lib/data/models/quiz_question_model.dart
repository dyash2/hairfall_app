class QuizQuestionModel {
  final String id;
  final String title;
  final List<OptionModel> options;
  final int order;
  final bool active;

  QuizQuestionModel({
    required this.id,
    required this.title,
    required this.options,
    required this.order,
    required this.active,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      options: (json["options"] as List)
          .map((item) => OptionModel.fromJson(item))
          .toList(),
      order: json["order"] ?? 0,
      active: json["active"] ?? false,
    );
  }
}

class OptionModel {
  final String id;
  final String key;
  final String label;

  OptionModel({
    required this.id,
    required this.key,
    required this.label,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json["_id"] ?? "",
      key: json["key"] ?? "",
      label: json["label"] ?? "",
    );
  }
}
