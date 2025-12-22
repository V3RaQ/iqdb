import 'package:flutter/material.dart';
import 'package:iqdb/Controllers/SearchController.dart';
import 'package:get/get.dart';
import '../../../Config/AppLists.dart';

class SearchTabsView extends StatelessWidget {
  const SearchTabsView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<GlobalSearchController>();
    return Expanded(
      child: PageView(
        controller: searchController.pageController,
        onPageChanged: searchController.onChangeTab,
        children: tabs
            .map<Widget>((tab) => tab['page']).toList(),
      ),
    );
  }
}
