import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieInformationController extends GetxController{
    RxMap<String, dynamic> movieInformation = <String, dynamic>{}.obs;
    RxList trailers = [].obs;
    RxList cast = [].obs;
    RxList similarMovies = [].obs;
    RxBool isLoading = true.obs;

    RxBool isClicked = false.obs;

    void clickedButton(){
      isClicked.value = !isClicked.value;
    }

    Future<void> getMovieInformation(int movieID) async {
      isLoading.value = true;
      movieInformation.clear();
      trailers.clear();
      cast.clear();
      similarMovies.clear();
      http.Response resMovie = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieID?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
      ));
      http.Response resTrailer = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieID/videos?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
      ));
      http.Response resCast = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
      ));
      http.Response resSimilarMovies = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieID/similar?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
      ));
      final data = json.decode(resTrailer.body)['results'];
      print(data);
      if(resMovie.statusCode == 200){
        movieInformation.value = json.decode(resMovie.body);
        trailers.value = json.decode(resTrailer.body)['results'];
        cast.value = json.decode(resCast.body)['cast'];
        similarMovies.value = json.decode(resSimilarMovies.body)['results'];
        await Future.delayed(Duration(seconds: 1));
        isLoading.value = false;
      }
      else{
        throw Exception("Failed to Load Movie Data");
      }
    }
}