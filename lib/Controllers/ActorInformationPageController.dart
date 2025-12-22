import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActorInformationController extends GetxController{
  RxMap<String, dynamic> actorInformation = <String, dynamic>{}.obs;
  RxList actingMovies = [].obs;
  RxBool isLoading = true.obs;


  Future<void> getActorInformation(int ActorID) async {

    http.Response resActor = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/$ActorID?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
    ));
    http.Response resActingMovies = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/$ActorID/movie_credits?api_key=0154f9c32da1f02deb6f0b5188be0b8a"
    ));
    if(resActor.statusCode == 200){
      actorInformation.value = json.decode(resActor.body);
      actingMovies.value = json.decode(resActingMovies.body)['cast'];
      isLoading.value = false;
    }
    else{
      throw Exception("Failed to Load Movie Data");
    }

  }
}