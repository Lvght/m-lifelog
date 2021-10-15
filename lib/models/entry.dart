class Entry {
  Entry({this.title, this.content});

  Entry.fromMap(Map<String, Object?> m) {
    title = m['title'] as String;
    content = m['content'] as String;
  }

  String? title;
  String? content;
  bool get isValid =>
      (title != null && title!.isNotEmpty) ||
      (content != null && content!.isNotEmpty);
}
