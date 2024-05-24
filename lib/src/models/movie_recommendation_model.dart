// ignore_for_file: non_constant_identifier_names

class MovieRecommendationModel {
  final num id;
  final String poster_path;
  final String original_title;
  final String overview;

  MovieRecommendationModel({
    required this.id,
    required this.poster_path,
    required this.original_title,
    required this.overview,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'poster_path': poster_path,
        'original_title': original_title,
        'overview': overview,
      };

  factory MovieRecommendationModel.fromMap(Map<String, dynamic> map) =>
      MovieRecommendationModel(
        id: map['id'],
        poster_path: map['poster_path'],
        original_title: map['original_title'],
        overview: map['overview'],
      );
}
