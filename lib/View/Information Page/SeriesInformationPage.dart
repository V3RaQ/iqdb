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
                            height: Get.height * 0.3,
                            width: Get.width,
                            child: Row(
                              spacing: 15,
                              children: [
                                // Movie Poster
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
                                ),
                                // Movie Information's
                                Column(
                                  spacing: 10,
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .start,
                                  children: [
                                    SizedBox(height: 15,),
                                    // Movie Year and Film Classification
                                    SizedBox(
                                      width: Get.width * 0.5,
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                TextSpan(text: "${controller.seriesInformation['release_date']}".split('-')[0]),
                                                TextSpan(text: ", "),
                                                TextSpan(text: (controller.seriesInformation['origin_country'] is List && controller.seriesInformation['origin_country'].isNotEmpty
                                                    ? controller.seriesInformation['origin_country'].join(", ").toUpperCase() : "")),
                                                TextSpan(text: ", "),
                                                TextSpan(text: (controller.seriesInformation['genres'] is List && controller.seriesInformation['genres'].isNotEmpty)
                                                    ? controller.seriesInformation['genres'].map((e) => e['name']).join(", ") : "") ,]
                                          )
                                      ),
                                    ),
                                    // Movie Rating and Original Language
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Container(
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
                                        ),
                                        Container(
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
                                            child: Text("${controller.seriesInformation["original_language"]}".toUpperCase()),
                                          ),
                                        )
                                      ],
                                    ),
                                    // Movie Status
                                    Flexible(
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
                                    ),
                                    // Movie Revenue
                                    Flexible(
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
                                  ],
                                )
                              ],
                            ),
                          ),
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
