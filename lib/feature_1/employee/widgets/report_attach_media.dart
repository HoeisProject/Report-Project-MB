import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget reportAttachMedia(BuildContext context, String fieldLabel,
    List<File?>? listMediaFile, void Function()? onPressed) {
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
      GridView.builder(
        itemCount: listMediaFile != null ? listMediaFile.length : 1,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return _attachMediaItem(listMediaFile![index], onPressed, index);
        },
      ),
    ],
  );
}

Widget _attachMediaItem(
    File? mediaFile, void Function()? onPressed, int itemLength) {
  return SizedBox(
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
  );
}
