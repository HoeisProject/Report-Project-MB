import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget customButton(
  BuildContext context,
  bool? isLoading,
  String labelText,
  Color buttonColor,
  void Function()? onPressed,
) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
    child: Center(
      child: SizedBox(
        height: 50.0,
        width: 150.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
          onPressed: isLoading! ? null : onPressed,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(labelText, style: kButtonTextStyle),
          ),
        ),
      ),
    ),
  );
}
