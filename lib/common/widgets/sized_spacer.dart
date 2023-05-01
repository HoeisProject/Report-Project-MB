import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget sizedSpacer({
  required BuildContext context,
  double height = 0.0,
  double width = 0.0,
  double thickness = 0.0,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: Divider(
      thickness: thickness,
      color: ConstColor(context)
          .getConstColor(ConstColorEnum.kOutlineBorderColor.name),
    ),
  );
}
