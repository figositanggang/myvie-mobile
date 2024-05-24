import 'package:flutter/material.dart';
import 'package:myvie/src/helpers/movie_helper.dart';
import 'package:myvie/src/models/people_model.dart';
import 'package:myvie/src/pages/movie_detail_page.dart';
import 'package:myvie/src/utils/constants.dart';
import 'package:myvie/src/utils/methods.dart';
import 'package:myvie/src/utils/widgets.dart';

class PeopleDetailPage extends StatefulWidget {
  final num personId;

  const PeopleDetailPage({super.key, required this.personId});

  @override
  State<PeopleDetailPage> createState() => _PeopleDetailPageState();
}

class _PeopleDetailPageState extends State<PeopleDetailPage> {
  late Future getPeopleDetail;
  late Future getPeopleMovieCredits;
  late Future getPeopleTVCredits;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void refresh() {
    getPeopleDetail = MovieHelper.getPeopleDetail(widget.personId);
    getPeopleMovieCredits = MovieHelper.getPeopleMovieCredits(widget.personId);
    getPeopleTVCredits = MovieHelper.getPeopleTVCredits(widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPeopleDetail,
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

        final person = PeopleModel.fromJson(snapshot.data!);
        String birthDay(String date) {
          final split = date.split("-");
          final month = months[int.parse(split[1]) - 1];
          return "$month ${split[2]}, ${split[0]}";
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(.5),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              refresh();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // @ Profile Picture
                  Container(
                    height: 600,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          person.profile_path != null
                              ? MovieHelper.IMAGE_URL + person.profile_path!
                              : 'https://via.placeholder.com/150',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // @ Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // @ Name
                        MyText(
                          person.name,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 5),

                        // @ Birth
                        MyText(
                          "Birth: ${birthDay(person.birthday)} ${person.place_of_birth}",
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20),

                        // @ Biography
                        _Section(
                          title: "Biography",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                person.biography,
                                fontSize: 16,
                                color: Colors.grey,
                                maxLines: isExpanded ? null : 5,
                                overflow: isExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: MyText(
                                      isExpanded ? "Read less" : "Read more"),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // @ Movie Credits
                        _Section(
                          title: "Movie Credits",
                          child: SizedBox(
                            height: 300,
                            child: FutureBuilder(
                              future: getPeopleMovieCredits,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (!snapshot.hasData || snapshot.hasError) {
                                  return const Center(
                                      child: Text("Ada kesalahan..."));
                                }

                                var credits = snapshot.data!;
                                if (credits.length > 5) {
                                  credits = credits.sublist(0, 5);
                                }

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: credits.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < credits.length) {
                                      final credit = MovieCreditModel.fromJson(
                                          credits[index]);

                                      return MovieCreditCard(
                                          movieCreditModel: credit);
                                    }

                                    return Center(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text("Lihat semua"),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        // @ TV Credits
                        _Section(
                          title: "TV Credits",
                          child: SizedBox(
                            height: 300,
                            child: FutureBuilder(
                              future: getPeopleTVCredits,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (!snapshot.hasData || snapshot.hasError) {
                                  return const Center(
                                      child: Text("Ada kesalahan..."));
                                }

                                var credits = snapshot.data!;
                                if (credits.length > 5) {
                                  credits = credits.sublist(0, 5);
                                }

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: credits.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < credits.length) {
                                      final credit = TVCreditModel.fromJson(
                                          credits[index]);

                                      return TVCreditCard(
                                          tvCreditModel: credit);
                                    }

                                    return Center(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text("Lihat semua"),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

class MovieCreditCard extends StatelessWidget {
  final MovieCreditModel movieCreditModel;

  const MovieCreditCard({super.key, required this.movieCreditModel});

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
                    MovieHelper.IMAGE_URL + movieCreditModel.poster_path!,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  navigateTo(MovieDetailPage(id: movieCreditModel.id), context);
                },
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MyText(movieCreditModel.original_title, maxLines: 2),
        ],
      ),
    );
  }
}

class TVCreditCard extends StatelessWidget {
  final TVCreditModel tvCreditModel;

  const TVCreditCard({super.key, required this.tvCreditModel});

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
                    MovieHelper.IMAGE_URL + tvCreditModel.poster_path!,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  navigateTo(MovieDetailPage(id: tvCreditModel.id), context);
                },
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MyText(tvCreditModel.original_name, maxLines: 2),
        ],
      ),
    );
  }
}
