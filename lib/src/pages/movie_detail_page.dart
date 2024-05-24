import 'package:flutter/material.dart';
import 'package:myvie/src/helpers/movie_helper.dart';
import 'package:myvie/src/models/cast_model.dart';
import 'package:myvie/src/models/genre_model.dart';
import 'package:myvie/src/models/movie_model.dart';
import 'package:myvie/src/models/movie_recommendation_model.dart';
import 'package:myvie/src/models/review_model.dart';
import 'package:myvie/src/utils/constants.dart';
import 'package:myvie/src/utils/methods.dart';
import 'package:myvie/src/utils/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  final num id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Future getMovie;
  late Future<List> getMovieRecommendations;
  late Future<List> getMovieCasts;
  late Future<List> getMovieReviews;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void refresh() {
    getMovie = MovieHelper.getMovie(widget.id);
    getMovieRecommendations = MovieHelper.getMovieRecommendations(widget.id);
    getMovieCasts = MovieHelper.getMovieCasts(widget.id);
    getMovieReviews = MovieHelper.getMovieReviews(widget.id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMovie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return Material(
            child: RefreshIndicator(
              onRefresh: () async {
                refresh();
              },
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: MyText("Ada kesalahan..."),
                ),
              ),
            ),
          );
        }

        final movie = MovieModel.fromMap(snapshot.data!);
        String releaseDate(String date) {
          final split = date.split("-");
          final month = months[int.parse(split[1]) - 1];
          return "$month ${split[2]}, ${split[0]}";
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Detail"),
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: RefreshIndicator(
              onRefresh: () async {
                refresh();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // @ Poster
                    Container(
                      height: 600,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              MovieHelper.IMAGE_URL + movie.posterPath),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // @ Title
                    Row(
                      children: [
                        Expanded(
                          child: MyText(
                            movie.originalTitle,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          color: Colors.amber,
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 15, color: Colors.black),
                              const SizedBox(width: 5),
                              MyText(
                                movie.voteAverage.toString(),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text("Release date: ${releaseDate(movie.releaseDate)}"),
                    const SizedBox(height: 10),

                    // @ Genres
                    Wrap(
                      children: List.generate(
                        movie.genres!.length,
                        (index) {
                          final genre =
                              GenreModel.fromMap(movie.genres![index]);

                          return GenreChip(genreModel: genre);
                        },
                      ),
                    ),
                    const SizedBox(height: 30),

                    // @ Overview
                    _Section(
                      title: "Overview",
                      child: MyText(
                        movie.overview != "" ? movie.overview : "No overview",
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.visible,
                        color: Colors.white.withOpacity(.75),
                      ),
                    ),

                    // @ Casts
                    FutureBuilder(
                      future: getMovieCasts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var data = snapshot.data!;
                        if (data.length > 5) {
                          data = snapshot.data!.sublist(0, 5);
                        }
                        return _Section(
                          title: "Casts",
                          child: SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: data.length + 1,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index < data.length) {
                                  final cast = CastModel.fromJson(data[index]);

                                  return CastCard(castModel: cast);
                                }

                                return Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text("Lihat semua"),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    // @ Recommendations
                    FutureBuilder(
                      future: getMovieRecommendations,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final data = snapshot.data!.sublist(0, 5);
                        return _Section(
                          title: "Recommendations",
                          child: SizedBox(
                            height: 325,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length + 1,
                              itemBuilder: (context, index) {
                                if (index < data.length) {
                                  final reccommendation =
                                      MovieRecommendationModel.fromMap(
                                          data[index]);

                                  return RecommendationCard(
                                      movieRecommendationModel:
                                          reccommendation);
                                }

                                return Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text("Lihat semua"),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    // @ Reviews
                    _Section(
                      title: "Reviews",
                      child: FutureBuilder(
                        future: getMovieReviews,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var data = snapshot.data!;
                          if (data.length > 5) {
                            data = snapshot.data!.sublist(0, 5);
                          }
                          return Column(
                            children: List.generate(
                              data.length,
                              (index) {
                                final review =
                                    ReviewModel.fromJson(data[index]);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(),
                                        MyText(
                                          review.author,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    MyText(
                                      review.content,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.visible,
                                      color: Colors.white.withOpacity(.75),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // @ Spacer
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        child,
        const SizedBox(height: 30)
      ],
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final MovieRecommendationModel movieRecommendationModel;
  const RecommendationCard({super.key, required this.movieRecommendationModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Expanded(
            child: Ink(
              width: 200,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(.25),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    MovieHelper.IMAGE_URL +
                        movieRecommendationModel.poster_path,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  navigateTo(context,
                      MovieDetailPage(id: movieRecommendationModel.id));
                },
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MyText(movieRecommendationModel.original_title, maxLines: 2),
        ],
      ),
    );
  }
}

class CastCard extends StatelessWidget {
  final CastModel castModel;
  const CastCard({super.key, required this.castModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Ink(
            width: 150,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(.25),
              // borderRadius: BorderRadius.circular(20),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  MovieHelper.IMAGE_URL + castModel.profile_path,
                ),
              ),
            ),
            child: InkWell(
              onTap: () {},
              customBorder: CircleBorder(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        MyText(castModel.name, maxLines: 2),
      ],
    );
  }
}
