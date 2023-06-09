import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant_style.dart';

Widget viewTextField(
    BuildContext context, String fieldLabel, String fieldContent, bool isDesc) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          child: Text(
            fieldLabel,
            style: kHeaderTextStyle,
          ),
        ),
        isDesc
            ? Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                height: 100.0,
                child: SingleChildScrollView(
                  child: Text(
                    fieldContent,
                    style: kInputTextStyle,
                  ),
                ),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                child: Text(
                  fieldContent,
                  style: kInputTextStyle,
                ),
              ),
      ],
    ),
  );
}
