import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeriesInformationController extends GetxController{
  RxMap<String, dynamic> seriesInformation = <String, dynamic>{}.obs;
  RxList trailers = [].obs;
  RxList cast = [].obs;
  RxList similarSeries = [].obs;
  RxBool isLoading = true.obs;

  RxBool isClicked = false.obs;

  void clickedButton(){
    isClicked.value = !isClicked.value;
  }

  Future<void> getSeriesInformation(int seriesID) async {
    isLoading.value = true;
    seriesInformation.clear();
    trailers.clear();
    cast.clear();
    similarSeries.clear();
    http.Response resMovie = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$seriesID?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
    ));
    http.Response resTrailer = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$seriesID/videos?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
    ));
    http.Response resCast = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$seriesID/credits?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
    ));
    http.Response resSimilarMovies = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/tv/$seriesID/similar?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
    ));
    final data = json.decode(resTrailer.body)['results'];
    print(data);
    if(resMovie.statusCode == 200){
      seriesInformation.value = json.decode(resMovie.body);
      trailers.value = json.decode(resTrailer.body)['results'];
      cast.value = json.decode(resCast.body)['cast'];
      similarSeries.value = json.decode(resSimilarMovies.body)['results'];
      isLoading.value = false;
    }
    else{
      throw Exception("Failed to Load Movie Data");
    }
  }
}