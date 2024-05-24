// ignore_for_file: non_constant_identifier_names

class MovieModel {
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String? backdropPath;
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

class MovieImageModel {
  final num aspect_ratio;
  final num height;
  final String file_path;
  final num width;

  MovieImageModel({
    required this.aspect_ratio,
    required this.height,
    required this.file_path,
    required this.width,
  });

  Map<String, dynamic> toMap() => {
        'aspect_ratio': aspect_ratio,
        'height': height,
        'file_path': file_path,
        'width': width,
      };

  factory MovieImageModel.fromMap(Map<String, dynamic> map) => MovieImageModel(
        aspect_ratio: map['aspect_ratio'],
        height: map['height'],
        file_path: map['file_path'],
        width: map['width'],
      );
}
