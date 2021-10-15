class Entry {
  Entry({required this.id, required this.createdAt, this.title, this.content});

  factory Entry.fromMap(Map<String, Object?> m) {
    int id = m['id'] != null ? m['id'] as int : 0;
    String? title = m['title'] != null ? m['title'] as String : null;
    String? content = m['content'] != null ? m['content'] as String : null;

    DateTime createdAt =
        DateTime.tryParse(m['created_at'] as String) ?? DateTime.now();

    return Entry(id: id, title: title, content: content, createdAt: createdAt);
  }

  final int id;
  String? title;
  String? content;
  DateTime createdAt;

  bool get isValid =>
      (title != null && title!.isNotEmpty) ||
      (content != null && content!.isNotEmpty);
}
