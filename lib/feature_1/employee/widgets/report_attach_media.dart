import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget reportAttachMedia(BuildContext context, String fieldLabel,
    List<File?> listMediaFile, void Function()? onPressed) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
        SizedBox(
          height: 100.0,
          child: GridView.builder(
            itemCount: listMediaFile.isEmpty ? 1 : listMediaFile.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              if (listMediaFile.isEmpty) {
                return InkWell(
                  onTap: onPressed,
                  child: const Icon(Icons.add_a_photo, size: 50.0),
                );
              }
              return _attachMediaItem(listMediaFile[index], onPressed, index);
            },
          ),
        ),
      ],
    ),
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
