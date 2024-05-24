class MovieModel {
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final num voteAverage;

  final List? genres;

  MovieModel({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genres,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'originalTitle': originalTitle,
        'overview': overview,
        'posterPath': posterPath,
        'backdropPath': backdropPath,
        'releaseDate': releaseDate,
        'voteAverage': voteAverage,
        'genres': genres,
      };

  factory MovieModel.fromMap(Map<String, dynamic> map) => MovieModel(
        id: map['id'],
        originalTitle: map['original_title'],
        overview: map['overview'],
        posterPath: map['poster_path'],
        backdropPath: map['backdrop_path'],
        releaseDate: map['release_date'],
        voteAverage: map['vote_average'],
        genres: map['genres'],
      );
}
