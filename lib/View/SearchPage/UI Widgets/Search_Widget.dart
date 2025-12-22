import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/SearchController.dart';

class SearchWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final Widget page;
  const SearchWidget({super.key, required this.imagePath, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<GlobalSearchController>();
    return Obx((){
      if(searchController.isLoading.value){
        return Center(child: CircularProgressIndicator(),);
      }
      final filtered = searchController.searchResult
          .where((searchParameter) => searchParameter[imagePath] != null)
          .toList();
      if (filtered.isEmpty || searchController.lastQueryText.isEmpty) {
        return Center(child: Text("No Result"));
      }
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 50,
            childAspectRatio: 0.8
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index){
          return Column(
            spacing: 5,
            children: [
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: (){
                      Get.to(page,
                      arguments: filtered[index]['id'],
                      transition: .fadeIn);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,

                ),
                child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1
                      ),
                        borderRadius: BorderRadius.circular(12),
                    ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network("https://image.tmdb.org/t/p/w500${filtered[index][imagePath]}",
                    fit: .cover,),
                  ),
                ),
              ),
              SizedBox(
                width: 75,
                child: Text(filtered[index][title],
                    textAlign: .center,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 12
                    )),
              )
            ],
          );
        },
      );
    });
  }
}
