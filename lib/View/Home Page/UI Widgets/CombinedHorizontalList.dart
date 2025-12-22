import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iqdb/Controllers/CombinedController.dart';

class CombinedHorizontalList extends StatelessWidget {
  final String listViewTitle;
  final String titlePath;
  final String imagePath;
  final List listResult;
  final Widget page;
  const CombinedHorizontalList({super.key,
    required this.listViewTitle, required this.titlePath,
    required this.listResult, required this.imagePath, required this.page
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CombinedController>();
    return SizedBox(
      width: .infinity,
      child: Obx((){
        if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
        }
        return Column(
          spacing: 5,
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(listViewTitle,
                style: TextStyle(
                  fontSize: 18,
                ),),
            ), // List Title
            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: .horizontal,
                itemCount: listResult.length,
                itemBuilder: (context, index){
                  return Column(
                    spacing: 5,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(page,
                          arguments: listResult[index]['id'],
                          transition: Transition.fadeIn);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.zero
                        ),
                        child: Container(
                          height: 150,
                          width: 110,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("https://image.tmdb.org/t/p/w500${listResult[index][imagePath]}")
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text(
                          listResult[index][titlePath],
                          textAlign: .center,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ), // Movies List View
          ],
        );
      }
      ),
    );
  }
}
