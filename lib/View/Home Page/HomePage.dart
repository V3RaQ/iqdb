import 'package:flutter/material.dart';
import 'package:iqdb/Controllers/CombinedController.dart';
import 'package:iqdb/View/Home%20Page/UI%20Widgets/FeaturedHeader_Widget.dart';
import 'package:iqdb/View/Home%20Page/UI%20Widgets/CombinedHorizontalList.dart';
import 'package:get/get.dart';
import 'package:iqdb/View/Information%20Page/MovieInformationPage.dart';
import 'package:iqdb/View/Information%20Page/SeriesInformationPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CombinedController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              FeaturedHeader(
                listResult: controller.topRatedMovies,
                titlePath: "title",
                imagePath: "poster_path"
              ), // Top Rated Slider
              CombinedHorizontalList(
                listViewTitle: "Popular Movies",
                listResult: controller.popularMovies,
                titlePath: "title",
                imagePath: "poster_path",
                page: MovieInformationPage(),
              ), // Popular Movies List
              CombinedHorizontalList(
                listViewTitle: "Today Trending Movies",
                listResult: controller.trendingDayMovies,
                titlePath: "title",
                imagePath: "poster_path",
                page: MovieInformationPage(),
              ), // Today Trending Movies List
              CombinedHorizontalList(
                listViewTitle: "Popular Series",
                listResult: controller.popularSeries,
                titlePath: "name",
                imagePath: "poster_path",
                page: SeriesInformationPage(),
              ), // Popular Series List
              CombinedHorizontalList(
                listViewTitle: "Today Trending Series",
                listResult: controller.trendingSeries,
                titlePath: "name",
                imagePath: "poster_path",
                page: SeriesInformationPage(),
              ), // Today Trending Seris List
            ],
          ),
        ),
      ),
    );
  }
}