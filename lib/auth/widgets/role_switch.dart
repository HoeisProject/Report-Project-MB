import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget roleSwitch(
  BuildContext context,
  String fieldLabel,
  bool isAdmin,
  void Function(bool)? onChange,
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
        Center(
          child: Switch(
            value: isAdmin,
            onChanged: onChange,
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
      ],
    ),
  );
}
