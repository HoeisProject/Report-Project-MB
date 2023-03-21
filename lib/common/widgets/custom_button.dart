import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget postCreateButton(BuildContext context, bool? isLoading, String labelText,
    void Function()? onPressed) {
  return Center(
    child: SizedBox(
      height: 50.0,
      width: 150.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: isLoading!
            ? null
            : onPressed,
        child: Center(
          child: isLoading ? const CircularProgressIndicator()
              : Text(labelText, style: kButtonTextStyle),
        ),
      ),
    ),
  );
}}