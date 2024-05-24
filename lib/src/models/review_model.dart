// ignore_for_file: non_constant_identifier_names

class ReviewModel {
  final String id;
  final String author;
  final Map author_details;
  final String content;

  ReviewModel({
    required this.id,
    required this.author,
    required this.author_details,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'author_details': author_details,
      'content': content,
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      author: json['author'],
      author_details: json['author_details'],
      content: json['content'],
    );
  }
}
