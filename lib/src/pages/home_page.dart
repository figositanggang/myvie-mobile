import 'package:flutter/material.dart';
import 'package:myvie/src/helpers/movie_helper.dart';
import 'package:myvie/src/models/movie_model.dart';
import 'package:myvie/src/models/tv_show_model.dart';
import 'package:myvie/src/utils/constants.dart';
import 'package:myvie/src/utils/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List> getNowPlaying;
  late Future<List> getAiringToday;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void refresh() {
    setState(() {
      getNowPlaying = MovieHelper.getNowPlaying();
      getAiringToday = MovieHelper.getAiringToday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          "Myvie",
          color: primaryColor,
          letterSpacing: 2,
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // @ Section Now Playing - Movies
              _Section(
                title: "Now Playing - Movies",
                child: FutureBuilder(
                  future: getNowPlaying,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.data!.sublist(0, 5);

                    return SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemCount: data.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index < data.length) {
                            final movie = MovieModel.fromMap(data[index]);

                            return NowPlayingCard(movieModel: movie);
                          }

                          return Center(
                            child: TextButton(
                              onPressed: () {},
                              child: const MyText("Lihat semua"),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),

              // @ Section Airing Today - TV Shows
              _Section(
                title: "Airing Today - TV Shows",
                child: FutureBuilder(
                  future: getAiringToday,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    final data = snapshot.data!.sublist(0, 5);
                    return SizedBox(
                      height: 250,
                      child: PageView.builder(
                        itemCount: data.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index < data.length) {
                            final tvShow = TVShowModel.fromMap(data[index]);

                            return AiringTodayCard(tvShowModel: tvShow);
                          }

                          return Container(
                            margin: const EdgeInsets.all(20),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  const Center(child: MyText("Lihat semua")),
                                  InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
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
        Padding(
          padding: const EdgeInsets.only(left: 17.0),
          child: MyText(
            title,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
