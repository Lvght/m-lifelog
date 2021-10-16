import 'dart:typed_data';

class Entry {
  Entry(
      {required this.id,
      required this.createdAt,
      required this.image,
      required this.title,
      required this.content,
      required this.sentiment});

  factory Entry.fromMap(Map<String, Object?> m) {
    int id = m['id'] as int? ?? 0;
    String? title = m['title'] as String?;
    String? content = m['content'] as String?;
    int? sentiment = m['feeling'] as int?;
    Uint8List? image = m['image'] as Uint8List?;

    DateTime createdAt = DateTime.now();
    if (m['created_at'] != null) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(m['created_at'] as int);
    }

    return Entry(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      sentiment: sentiment,
      image: image,
    );
  }

  final int id;
  final String? title;
  final String? content;
  final DateTime createdAt;
  final int? sentiment;
  final Uint8List? image;

  bool get isValid =>
      (title != null && title!.isNotEmpty) ||
      (content != null && content!.isNotEmpty);
}
