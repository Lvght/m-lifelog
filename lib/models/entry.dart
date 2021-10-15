class Entry {
  Entry(
      {required this.id,
      required this.createdAt,
      this.title,
      this.content,
      this.sentiment});

  factory Entry.fromMap(Map<String, Object?> m) {
    int id = m['id'] as int? ?? 0;
    String? title = m['title'] as String?;
    String? content = m['content'] as String?;
    int? sentiment = m['feeling'] as int?;

    DateTime createdAt =
        DateTime.tryParse(m['created_at'] as String) ?? DateTime.now();

    return Entry(
        id: id,
        title: title,
        content: content,
        createdAt: createdAt,
        sentiment: sentiment);
  }

  final int id;
  String? title;
  String? content;
  DateTime createdAt;
  int? sentiment;

  bool get isValid =>
      (title != null && title!.isNotEmpty) ||
      (content != null && content!.isNotEmpty);
}
