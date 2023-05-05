import 'package:flutter/material.dart';

const kAppbarTextStyle = TextStyle(
  fontSize: 28.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.bold,
);

const kTitleContextStyle = TextStyle(
  fontSize: 24.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.bold,
);

const kHeaderTextStyle = TextStyle(
  fontSize: 18.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.normal,
);

const kInputTextStyle = TextStyle(
  fontSize: 14.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w400,
);

const kButtonTextStyle = TextStyle(
  fontSize: 18.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.bold,
);

const kTitleReportItem = TextStyle(
  fontSize: 15.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.bold,
);

const kContentReportItem = TextStyle(
  fontSize: 14.0,
  letterSpacing: 0.5,
  fontWeight: FontWeight.normal,
);

enum ConstColorEnum {
  kBgColor,
  kOutlineBorderColor,
  kIconColor,
}

class ConstColor {
  final BuildContext context;

  ConstColor(this.context);

  Color getConstColor(String constColorId) {
    switch (constColorId) {
      case 'kBgColor':
        Color color = Theme.of(context).scaffoldBackgroundColor;
        return color;
      case 'kOutlineBorderColor':
        Color color = Theme.of(context).indicatorColor;
        return color;
      default:
        Color color = Colors.transparent;
        return color;
    }
  }
}
