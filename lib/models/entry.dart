class Entry {
  Entry({this.title, this.content});

  Entry.fromMap(Map<String, Object?> m) {
    title = m['title'] != null ? m['title'] as String : null;
    content = m['content'] != null ? m['content'] as String : null;
  }

  String? title;
  String? content;
  bool get isValid =>
      (title != null && title!.isNotEmpty) ||
      (content != null && content!.isNotEmpty);
}
