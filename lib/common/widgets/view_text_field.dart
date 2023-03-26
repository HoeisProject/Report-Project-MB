import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget viewTextField(
    BuildContext context, String fieldLabel, String fieldContent) {
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          // decoration: const BoxDecoration(
          //   border: Border(
          //     bottom: BorderSide(width: 1.0, color: Colors.black),
          //   ),
          // ),
          child: Text(
            fieldContent,
            style: kInputTextStyle,
          ),
        ),
      ],
    ),
  );
}
