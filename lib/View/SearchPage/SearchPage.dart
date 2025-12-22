import 'package:flutter/material.dart';
import 'package:iqdb/View/SearchPage/UI%20Widgets/SearchTabsView_Widget.dart';
import 'package:iqdb/View/SearchPage/UI%20Widgets/TabsBar_Widget.dart';
import '../../Controllers/SearchController.dart';
import 'UI Widgets/SearchTextField_Widget.dart';
import 'package:get/get.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(GlobalSearchController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 10,
            children: [
                SearchTextFieldWidget(
                    enabled: true,
                    controller: searchController,
                ),
                TabsBar(),
                SearchTabsView()
            ],
          ),
        ),
      ),
    );
  }
}
