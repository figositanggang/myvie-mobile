import 'package:dio/dio.dart';

class MovieHelper {
  static const String IMAGE_URL = "https://image.tmdb.org/t/p/original/";
  static Dio dio = Dio();

  //! get now playing - movies
  static Future<List> getNowPlaying({int page = 1}) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data['results'] as List;
  }

  // ! get airing today - tv shows
  static Future<List> getAiringToday() async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/tv/airing_today',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data['results'] as List;
  }

  // ! get a movie
  static Future<Map> getMovie(num id) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/movie/$id',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data;
  }

  // ! get movie recommendations
  static Future<List> getMovieRecommendations(num id) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/movie/$id/recommendations',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data['results'] as List;
  }

  // ! get movie casts
  static Future<List> getMovieCasts(num id) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/movie/$id/credits',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data['cast'] as List;
  }

  // ! get movie reviews
  static Future<List> getMovieReviews(num id) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/movie/$id/reviews',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data['results'] as List;
  }

  // ! get movie images
  static Future<List> getMovieImages(num id) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/movie/$id/images',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data['backdrops'] as List;
  }

  // ! get people detail
  static Future<Map> getPeopleDetail(num id) async {
    Response res = await dio.get(
      'https://api.themoviedb.org/3/person/$id',
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDcyNzQzODBmMTVlYjdhOTE5OTY0YmE1YmM2NTQxMiIsInN1YiI6IjYxZmJiYjliNDE0MjkxMDExNTM0MTkzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UUVhVRV0LhFvh4jWhn6bsBJOtNOgpwmexuPK0JJEoDU'
        },
      ),
    );

    return res.data;
  }
}
