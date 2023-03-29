import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget viewMediaField(
    BuildContext context, String fieldLabel, List<String?> listMediaFilePath) {
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
          height: 100.0,
          child: GridView.builder(
            itemCount: listMediaFilePath.isEmpty ? 1 : listMediaFilePath.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              if (listMediaFilePath.isEmpty) {
                return const Icon(Icons.image_not_supported, size: 50.0);
              }
              return _attachMediaItem(listMediaFilePath[index], () {}, index);
            },
          ),
        ),
      ],
    ),
  );
}

Widget _attachMediaItem(
    String? mediaFilePath, void Function()? onPressed, int itemLength) {
  return SizedBox(
    width: 75.0,
    height: 75.0,
    child: mediaFilePath != null
        ? Image.network(
            mediaFilePath,
            fit: BoxFit.cover,
          )
        : const Icon(Icons.add_a_photo, size: 50.0),
  );
}
