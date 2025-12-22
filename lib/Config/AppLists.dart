import '../View/SearchPage/SearchTabs/SearchMoviesResult.dart';
import '../View/SearchPage/SearchTabs/SearchTVsResult.dart';

List<Map<String, dynamic>> tabs = [
  {"title" : "Movies", "page" : SearchMoviesResult(), "endpoint" : "https://api.themoviedb.org/3/search/movie?api_key=0154f9c32da1f02deb6f0b5188be0b8a&query="},
  {"title" : "T.Vs", "page"   : SearchTVsResult(),    "endpoint" : "https://api.themoviedb.org/3/search/tv?api_key=0154f9c32da1f02deb6f0b5188be0b8a&query="},
];