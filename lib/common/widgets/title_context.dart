import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget titleContext(String label) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
    child: Center(
      child: Text(
        label,
        style: kTitleContextStyle,
      ),
    ),
  );
}
