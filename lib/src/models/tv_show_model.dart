class TVShowModel {
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String backdropPath;

  final num voteAverage;

  TVShowModel({
    required this.id,
    required this.originalName,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'originalTitle': originalName,
        'overview': overview,
        'posterPath': posterPath,
        'backdropPath': backdropPath,
        'firstAirDate': firstAirDate,
        'voteAverage': voteAverage,
      };

  factory TVShowModel.fromMap(Map<String, dynamic> map) => TVShowModel(
        id: map['id'],
        originalName: map['original_name'],
        overview: map['overview'],
        backdropPath: map['backdrop_path'],
        posterPath: map['poster_path'],
        firstAirDate: map['first_air_date'],
        voteAverage: map['vote_average'],
      );
}
