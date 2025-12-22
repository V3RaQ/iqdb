import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iqdb/Controllers/SearchController.dart';
import '../../../Config/AppLists.dart';

class TabsBar extends StatelessWidget {
  const TabsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<GlobalSearchController>();
    return Obx((){
      return Row(
        mainAxisAlignment: .spaceEvenly,
        children: List.generate(
            tabs.length,
                (index){
              final isSelected = searchController.selectedIndex.value == index;
              return Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: 75,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: InkWell(
                      onTap: () {
                        searchController.onChangeTab(index);
                      },
                      splashColor: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      highlightColor: Colors.white.withOpacity(0.1),
                      child: Text(tabs[index]['title'],
                        textAlign: .center,
                      )
                    ),
                  ),
                ],
              );
            }),
      );
    });
  }
}
