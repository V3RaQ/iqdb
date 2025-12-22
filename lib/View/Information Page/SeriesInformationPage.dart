import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqdb/Controllers/SeriesInformationPageController.dart';
import 'package:url_launcher/url_launcher.dart';

class SeriesInformationPage extends StatelessWidget {
  const SeriesInformationPage({super.key});
  @override
  Widget build(BuildContext context) {
    final int seriesID = Get.arguments;
    final controller = Get.put(SeriesInformationController());
    controller.getSeriesInformation(seriesID);
    final formatter = NumberFormat.currency(
        locale: "en_US",
        symbol: r'$',
        decimalDigits: 2
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Obx(
                      (){
                    if(controller.isLoading.value){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: .start,
                        crossAxisAlignment: .start,
                        spacing: 15,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 350,
                                  child: Text("${controller.seriesInformation['name']}",
                                    style: TextStyle(
                                        fontSize: 18
                                    ),),
                                ),
                                Spacer(),
                                Obx(() {
                                  return Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Center(
                                      child: IconButton(onPressed: (){
                                        controller.clickedButton();
                                      },
                                          style: IconButton.styleFrom(
                                              padding: EdgeInsets.zero
                                          ),
                                          icon: Icon(
                                            controller.isClicked.value ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                            color: Colors.red,)),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ), // Movie Title and the Favorite Button
                          SizedBox(
                            height: 230,
                            width: Get.width,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 25,
                                  child: controller.seriesInformation['poster_path'] == null ?
                                  Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.9),
                                              spreadRadius: 5,
                                              blurRadius: 30,
                                              offset: Offset(10, 10)
                                          ),
                                        ]
                                    ),
                                    child: Center(child: Text("No Image"),),
                                  )
                                      :
                                  Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage("https://image.tmdb.org/t/p/w500${controller.seriesInformation['poster_path']}"),
                                            fit: BoxFit.cover
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.9),
                                              spreadRadius: 5,
                                              blurRadius: 30,
                                              offset: Offset(10, 10)
                                          )
                                        ]
                                    ),
                                  )),
                                Positioned(
                                    top: 20,
                                    left: 185,
                                    child: SizedBox(
                                      width: Get.width * 0.5,
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: "${controller.seriesInformation['first_air_date']}".split('-')[0]),
                                                TextSpan(text: ", "),
                                                TextSpan(text: (controller.seriesInformation['languages'] is List && controller.seriesInformation['languages'].isNotEmpty
                                                    ? controller.seriesInformation['languages'].join(", ").toUpperCase() : "")),
                                                TextSpan(text: ", "),
                                                TextSpan(text: (controller.seriesInformation['genres'] is List && controller.seriesInformation['genres'].isNotEmpty)
                                                    ? controller.seriesInformation['genres'].map((e) => e['name']).join(", ") : "") ,]
                                          )
                                      ),
                                    )
                                ),
                                Positioned(
                                    top: 80,
                                    left: 185,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: controller.seriesInformation["vote_average"] < 6.5 ? Colors.purple :
                                              controller.seriesInformation["vote_average"] > 6.5 ? Colors.yellow : Colors.green ,
                                              width: 2
                                          )
                                      ),
                                      child: Center(
                                        child: Text("${controller.seriesInformation["vote_average"].toStringAsFixed(1)}"),
                                      ),
                                    )
                                ),
                                Positioned(
                                    top: 80,
                                    left: 230,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Colors.green,
                                              width: 2
                                          )
                                      ),
                                      child: Center(
                                        child: Text("${(controller.seriesInformation["original_language"]) ?? "No"}".toUpperCase()),
                                      ),
                                    )
                                ),
                                Positioned(
                                    top: 120,
                                    left: 185,
                                    child: SizedBox(
                                      width: Get.width * 0.5,
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: "Status\n"),
                                                TextSpan(text: "${controller.seriesInformation['status']}",
                                                    style: TextStyle(
                                                        color: Colors.green
                                                    )),
                                              ]
                                          )
                                      ),
                                    )
                                ), // Status Text
                                Positioned(
                                    top: 160,
                                    left: 185,
                                    child: SizedBox(
                                      width: Get.width * 0.5,
                                      // child: Text.rich(
                                      //     TextSpan(
                                      //         children: [
                                      //           TextSpan(text: "Revenue\n"),
                                      //           TextSpan(text: formatter.format(controller.seriesInformation['revenue']),
                                      //               style: TextStyle(
                                      //                   color: Colors.green
                                      //               )),
                                      //         ]
                                      //     )
                                      // ),
                                    )
                                ), // Status (Information)
                                Positioned(
                                    top: 160,
                                    left: 185,
                                    child: SizedBox(
                                      width: Get.width * 0.5,
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: "Revenue\n"),
                                                TextSpan(text: formatter.format(controller.seriesInformation['revenue'] ?? 0),
                                                    style: TextStyle(
                                                        color: Colors.green
                                                    )),
                                              ]
                                          )
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ), // Movie Information's
                          Text("Original Title",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9)
                            ),), // Original Title for the Movie Text
                          Text(controller.seriesInformation['name'] ?? "No Original Title",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),), // Original Title for the Movie (Information)
                          Text("Overview",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),), // Overview Text
                          Text(
                            controller.seriesInformation['overview'] ?? "No Overview",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),), // Overview (Information)
                          Text("Trailers",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),), // Trailers Text
                          SizedBox(
                            height: 150,
                            child: controller.trailers.isEmpty ?
                            Center(child: Text("No Trailers"),) :
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.trailers.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage("https://img.youtube.com/vi/${controller.trailers[index]["key"]}/maxresdefault.jpg")
                                        )
                                    ),
                                    child: Center(
                                      child: IconButton(onPressed: () async {
                                        launchUrl(Uri.parse("https://www.youtube.com/watch?v=${controller.trailers[index]['key']}"),
                                            mode: LaunchMode.externalApplication);
                                      },
                                          icon: Icon(Icons.play_circle_outline,
                                            size: 50,
                                            color: Colors.white,)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ), // Trailers
                          Text("Cast",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),), // Cast Text
                          SizedBox(
                            height: 300,
                            child: controller.cast.isEmpty ?
                            Center(child: Text("No Cast"),) :
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.trailers.length,
                              itemBuilder: (context, index){
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 125,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage("https://image.tmdb.org/t/p/w500${controller.cast[index]['profile_path']}"),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: Text("${controller.cast[index]['name']}",
                                              textAlign: TextAlign.center,
                                            )),
                                        SizedBox(
                                          width: 150,
                                          child: Text("${controller.cast[index]['character']}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.5)
                                            ),),
                                        )
                                      ],
                                    )
                                );
                              },
                            ),
                          ), // Cast
                          SizedBox(
                            height: 300,
                            child: controller.similarSeries.isEmpty ?
                            Center(child: Text("No Similar Movies"),) :
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.similarSeries.length,
                              itemBuilder: (context, index){
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: (){
                                            Get.delete<SeriesInformationController>();
                                            Get.off(SeriesInformationPage(),
                                              preventDuplicates: false,
                                              arguments: controller.similarSeries[index]['id'],
                                              transition: Transition.fadeIn,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              padding: .zero
                                          ),
                                          child: controller.similarSeries[index]['poster_path'] == null ?
                                          Container(
                                            width: 125,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white
                                              ),
                                            ),
                                            child: Center(
                                              child: Text("No Image",
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),),
                                            ),
                                          )
                                              :
                                          Container(
                                            width: 125,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white
                                                ),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://image.tmdb.org/t/p/w500${controller.similarSeries[index]['poster_path']}"
                                                    ),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text("${controller.similarSeries[index]['name']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            softWrap: true,),
                                        )
                                      ],
                                    )
                                );
                              },
                            ),
                          ), // Similar Movies
                        ],
                      ),
                    );
                  }
              )
          ),
        ),
      ),
    );
  }
}
