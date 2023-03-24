import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget viewMediaField(
    BuildContext context, String fieldLabel, File? mediaFile) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        child: Text(
          fieldLabel,
          style: kHeaderTextStyle,
        ),
      ),
      Center(
        child: SizedBox(
          width: 75.0,
          height: 75.0,
          child: mediaFile != null
              ? Image.file(
                  mediaFile,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.photo, size: 50.0),
        ),
      ),
    ],
  );
}
