import 'package:flutter/material.dart';
import 'package:iqdb/View/Information%20Page/MovieInformationPage.dart';
import 'package:iqdb/View/SearchPage/UI%20Widgets/Search_Widget.dart';

class SearchMoviesResult extends StatelessWidget {
  const SearchMoviesResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchWidget(
      imagePath: "poster_path",
      title: "title",
      page: MovieInformationPage(),
    );
  }
}