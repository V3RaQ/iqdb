import 'package:flutter/material.dart';
import 'package:iqdb/Config/Colors.dart';
import 'package:get/get.dart';
import '../../Controllers/ActorInformationPageController.dart';
import 'MovieInformationPage.dart';

class ActorInformation extends StatelessWidget {
  const ActorInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActorInformationController());
    final int actorID = Get.arguments;
    controller.getActorInformation(actorID);
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if(controller.isLoading.value){
            return Center(child: CircularProgressIndicator(),);
          }
          return Text(controller.actorInformation['name'],
            style: TextStyle(
                color: Colors.white
            ),);
        },
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(() {
              if(controller.isLoading.value){
                return Center(child: CircularProgressIndicator(),);
              }
              return Column(
                crossAxisAlignment: .start,
                spacing: 25,
                children: [
                  Center(
                    child: Container(
                      width: 150,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${controller
                                    .actorInformation['profile_path']}"),
                            fit: BoxFit.contain
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Text("Biography"),
                  Text(controller.actorInformation['biography'],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5)
                    ),),
                  Text("Acting"),
                  SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.actingMovies.length,
                        itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: (){
                                Get.delete<ActorInformationController>();
                                Get.to(
                                  MovieInformationPage(),
                                  arguments: controller.actingMovies[index]['id'],
                                  transition: Transition.fadeIn
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: .zero
                              ),
                              child: controller.actingMovies[index]['poster_path'] == null ?
                              SizedBox(
                                width: 150,
                                child: Center(child: Text("No Image"),),
                              )
                                  :
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage("https://image.tmdb.org/t/p/w500${controller
                                        .actingMovies[index]['poster_path']}")
                                  )
                                ),
                              ),
                            );
                        },
                      )
                  )
                ],
              );
            }
            ),
          ),
        ),
      ),
    );
  }
}
