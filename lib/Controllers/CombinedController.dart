import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CombinedController extends GetxController{
  RxList topRatedMovies = [].obs;
  RxList popularMovies = [].obs;
  RxList trendingDayMovies = [].obs;
  RxList popularSeries = [].obs;
  RxList trendingSeries = [].obs;

  RxBool isLoading = true.obs;
  ApiLinks apiLinks = ApiLinks();

  @override
  void onInit(){
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async{
    http.Response resTopRatedMovie = await http.get(Uri.parse(
        apiLinks.baseLink + apiLinks.topRatedMovieEndPoint + apiLinks.apiKey
    ));
    http.Response resPopularMovie = await http.get(Uri.parse(
        apiLinks.baseLink + apiLinks.popularMovieEndPoint + apiLinks.apiKey
    ));
    http.Response resTrendingDayMovie = await http.get(Uri.parse(
       apiLinks.baseLink + apiLinks.trendingDayMovieEndPoint + apiLinks.apiKey
    ));
    http.Response resPopularSeries = await http.get(Uri.parse(
      apiLinks.baseLink + apiLinks.popularSeriesEndPoint + apiLinks.apiKey
    ));
    http.Response resTrendingDaySeries = await http.get(Uri.parse(
      apiLinks.baseLink + apiLinks.trendingDaySeriesEndPoint + apiLinks.apiKey
    ));
    try{
        topRatedMovies.value = json.decode(resTopRatedMovie.body)['results'];
        popularMovies.value = json.decode(resPopularMovie.body)['results'];
        trendingDayMovies.value = json.decode(resTrendingDayMovie.body)['results'];
        popularSeries.value = json.decode(resPopularSeries.body)['results'];
        trendingSeries.value = json.decode(resTrendingDaySeries.body)['results'];
    }
    catch (e){
      print("Error loading data: $e");
    }
    isLoading.value = false;
  }
}

class ApiLinks {
  String baseLink = "https://api.themoviedb.org/3/";
  String apiKey = "?api_key=0154f9c32da1f02deb6f0b5188be0b8a";
  String topRatedMovieEndPoint = "movie/top_rated";
  String popularMovieEndPoint = "movie/popular";
  String trendingDayMovieEndPoint = "trending/movie/day";
  String popularSeriesEndPoint = "tv/popular";
  String trendingDaySeriesEndPoint = "trending/tv/day";
}

