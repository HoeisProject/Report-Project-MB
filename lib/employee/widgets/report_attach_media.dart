import 'dart:io';

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

// import 'package:image_picker/image_picker.dart';
import 'package:report_project/common/styles/constant_style.dart';

Widget reportAttachMedia(BuildContext context, String fieldLabel,
    List<Media> listMediaFile, void Function()? onPressed) {
  return Container(
    margin: const EdgeInsets.all(10.0),
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
          height: listMediaFile.isEmpty ? 125.0 : 200.0,
          child: GridView.builder(
            physics: listMediaFile.isEmpty
                ? const NeverScrollableScrollPhysics()
                : const ScrollPhysics(),
            itemCount: listMediaFile.isEmpty ? 1 : listMediaFile.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              if (listMediaFile.isEmpty) {
                return _attachMediaButton(onPressed);
              }
              if ((index + 1) <= listMediaFile.length) {
                return _attachMediaItem(listMediaFile[index]);
              }
              return _attachMediaButton(onPressed);
            },
          ),
        ),
      ],
    ),
  );
}

Widget _attachMediaItem(Media mediaFile) {
  return SizedBox(
    width: 75.0,
    height: 75.0,
    child: Image.file(
      File(mediaFile.path),
      fit: BoxFit.cover,
    ),
  );
}

Widget _attachMediaButton(void Function()? onPressed) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(),
    ),
    width: 75.0,
    height: 75.0,
    child: InkWell(
      onTap: onPressed,
      child: const Icon(Icons.add_a_photo, size: 50.0),
    ),
  );
}
