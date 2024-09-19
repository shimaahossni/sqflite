class Notes{
  final int? id;
  final String title;
  final String content;
  Notes({ this.id,required this.title,required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}