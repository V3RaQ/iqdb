import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iqdb/Controllers/SearchController.dart';
import 'package:iqdb/View/SearchPage/SearchPage.dart';
class SearchTextFieldWidget extends StatelessWidget {
  final bool enabled;
  final GlobalSearchController? controller;
  const SearchTextFieldWidget({super.key, required this.enabled, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.95,
      child: InkWell(
        onTap: (){
          Get.to(SearchPage());
        },
        child: TextFormField(
          style: TextStyle(
              color: Colors.black
          ),
          cursorColor: Colors.black,
          enabled: enabled,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_outlined),
              hintText: "Search Movie, T.V, Actor",
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: Colors.transparent
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: Colors.transparent
                ),
              )
          ),
          onChanged: (value){
            if(controller != null){
              controller!.lastQueryText.value = value;
              controller!.getSearchData(controller!.endpointPath, value);
            }
          },
        ),
      ),
    );
  }
}
