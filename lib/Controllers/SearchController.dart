import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Config/AppLists.dart';

class GlobalSearchController extends GetxController{
  RxList searchResult = [].obs;
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;
  RxString lastQueryText = "".obs;
  late PageController pageController;

  String get endpointPath => tabs[selectedIndex.value]['endpoint'];

  GlobalSearchController(){
    pageController = PageController();
  }

  void onChangeTab(int index){
    selectedIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 250),
      curve: Curves.linear
    );
    pageController.jumpToPage(index);
    if(lastQueryText.value.trim().isNotEmpty){
      getSearchData(endpointPath, lastQueryText.value);
    }
  }
  Future<void> getSearchData(String endpoint, String query) async {
    if(query.trim().isEmpty){
      searchResult.clear();
      return;
    }
    isLoading.value = true;
    Uri url = Uri.parse(endpoint + query);
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      searchResult.value = data['results'];
    }
    else{
      throw Exception("Failed to Load Results");
    }
    isLoading.value = false;
  }
}