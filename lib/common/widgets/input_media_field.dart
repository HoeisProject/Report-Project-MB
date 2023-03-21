import 'dart:io';

import 'package:flutter/material.dart';

import '../styles/constant.dart';

Widget inputMediaField(BuildContext context, String fieldLabel, File? mediaFile,
    void Function()? onPressed) {
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
              ? InkWell(
                  onTap: onPressed,
                  child: Image.file(
                    mediaFile,
                    fit: BoxFit.cover,
                  ),
                )
              : InkWell(
                  onTap: onPressed,
                  child: const Icon(Icons.add_a_photo, size: 50.0),
                ),
        ),
      ),
    ],
  );
}
