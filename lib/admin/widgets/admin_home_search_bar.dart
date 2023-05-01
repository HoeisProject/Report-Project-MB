import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/view_model/admin_home_view_model.dart';

Widget adminHomeSearchBar(BuildContext context, WidgetRef ref,
    TextEditingController searchController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          debugPrint("onChanged :");
          ref.read(adminHomeSearchTextProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              ref.read(adminHomeSearchTextProvider.notifier).state = "";
              searchController.clear();
            },
          ),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              debugPrint("onPressed :");
              ref.read(adminHomeSearchTextProvider.notifier).state =
                  searchController.text;
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
  );
}
