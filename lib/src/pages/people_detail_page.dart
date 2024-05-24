import 'package:flutter/material.dart';
import 'package:myvie/src/helpers/movie_helper.dart';
import 'package:myvie/src/models/cast_model.dart';
import 'package:myvie/src/utils/widgets.dart';

class PeopleDetailPage extends StatefulWidget {
  final num personId;
  const PeopleDetailPage({super.key, required this.personId});

  @override
  State<PeopleDetailPage> createState() => _PeopleDetailPageState();
}

class _PeopleDetailPageState extends State<PeopleDetailPage> {
  late Future getPeopleDetail;
  late Future getPeopleCredits;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void refresh() {
    getPeopleDetail = MovieHelper.getPeopleDetail(widget.personId);
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

        return Scaffold(
          appBar: AppBar(),
          body: RefreshIndicator(
            onRefresh: () async {
              refresh();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
