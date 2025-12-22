import 'package:flutter/material.dart';
import 'package:iqdb/View/Information%20Page/SeriesInformationPage.dart';
import 'package:iqdb/View/SearchPage/UI%20Widgets/Search_Widget.dart';

class SearchTVsResult extends StatelessWidget {
  const SearchTVsResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      imagePath: "poster_path",
      title: "name",
      page: SeriesInformationPage(),
    );
  }
}