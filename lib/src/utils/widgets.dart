import 'package:flutter/material.dart';
import 'package:myvie/src/helpers/movie_helper.dart';
import 'package:myvie/src/models/genre_model.dart';
import 'package:myvie/src/models/movie_model.dart';
import 'package:myvie/src/models/tv_show_model.dart';
import 'package:myvie/src/pages/movie_detail_page.dart';
import 'package:myvie/src/utils/constants.dart';
import 'package:myvie/src/utils/methods.dart';

class MyText extends StatelessWidget {
  final String data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;

  const MyText(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.letterSpacing,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

class NowPlayingCard extends StatelessWidget {
  final MovieModel movieModel;
  const NowPlayingCard({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(.25),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(.1),
                blurRadius: 20,
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  NetworkImage(MovieHelper.IMAGE_URL + movieModel.backdropPath),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black.withOpacity(.75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              movieModel.originalTitle,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const Icon(Icons.star, size: 15, color: Colors.amber),
                          const SizedBox(width: 5),
                          MyText(movieModel.voteAverage.toString(),
                              color: Colors.amber),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, MovieDetailPage(id: movieModel.id));
                },
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AiringTodayCard extends StatelessWidget {
  final TVShowModel tvShowModel;
  const AiringTodayCard({super.key, required this.tvShowModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(.1),
                blurRadius: 20,
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  NetworkImage(MovieHelper.IMAGE_URL + tvShowModel.posterPath),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black.withOpacity(.75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              tvShowModel.originalName,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const Icon(Icons.star, size: 15, color: Colors.amber),
                          const SizedBox(width: 5),
                          MyText(tvShowModel.voteAverage.toString(),
                              color: Colors.amber),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// @ Genre Chip
class GenreChip extends StatelessWidget {
  final GenreModel genreModel;
  const GenreChip({super.key, required this.genreModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: primaryColor,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: MyText(genreModel.name),
            ),
          ),
        ),
      ),
    );
  }
}
