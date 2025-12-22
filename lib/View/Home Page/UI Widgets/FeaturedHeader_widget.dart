import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iqdb/Config/Colors.dart';
import '../../../Controllers/CombinedController.dart';
import '../../SearchPage/UI Widgets/SearchTextField_Widget.dart';

class FeaturedHeader extends StatelessWidget {
  final String titlePath;
  final List listResult;
  final String imagePath;
  const FeaturedHeader({super.key, required this.titlePath, required this.listResult, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CombinedController>();
    return Container(
      height: 400,
      width: .infinity,
      color: containerColor,
      child: Column(
        spacing: 15,
        mainAxisAlignment: .start,
        children: [
          Obx((){
            if(controller.isLoading.value){
              return Center(child: CircularProgressIndicator());
            }
            return CarouselSlider.builder(
                itemCount: listResult.length,
                itemBuilder: (context, index, realIndex){
                  return Stack(
                    clipBehavior: .none,
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w500${listResult[index]['backdrop_path']}"
                        ), //Poster Movie Images
                      Positioned(
                        bottom: 25,
                        left: 10,
                        child: Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.white
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${listResult[index]['poster_path']}"
                                  )
                              )
                          ),
                        ),
                      ), //Cover Movie Images
                      Positioned(
                        bottom: 50,
                        left: 117,
                        child: Text(
                          listResult[index][titlePath],
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ), //Movie Title
                      Positioned(
                        bottom: 30,
                        left: 117,
                        child: Text(
                        listResult[index]['release_date'],
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 13
                          ),
                        ),
                      ), // Movie Release Date
                    ],
                  );
                },
                options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    height: 315
                ));
          }), //Movie Information (Poster image, Cover image, Title, Release Date)
          SearchTextFieldWidget(
              enabled: false,
          ),
        ],
      ),
    );
  }
}
