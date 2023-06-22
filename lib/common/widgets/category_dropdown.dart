import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant_style.dart';

Widget categoryDropdown(
  BuildContext context,
  String fieldLabel,
  String? projectCategorySelected,
  List<DropdownMenuItem<String>> projectCategories,
  void Function(String?)? onChanged,
  Widget? icon,
) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          child: Text(
            "$fieldLabel : ",
            style: kHeaderTextStyle,
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          itemHeight: null,
          value: projectCategorySelected,
          items: projectCategories,
          onChanged: onChanged,
          icon: icon,
        ),
      ],
    ),
  );
}
