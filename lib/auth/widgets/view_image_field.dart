import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:report_project/common/styles/constant.dart';

Widget viewImageField(
    BuildContext context, String fieldLabel, String? mediaFilePath) {
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
        Center(
          child: SizedBox(
            width: 125.0,
            height: 150.0,
            child: mediaFilePath != null
                ? PhotoView(
                    loadingBuilder: (context, event) => Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  (event.expectedTotalBytes ?? 1),
                        ),
                      ),
                    ),
                    imageProvider: NetworkImage(
                      mediaFilePath,
                    ),
                  )
                : const Icon(Icons.add_a_photo, size: 50.0),
          ),
        ),
      ],
    ),
  );
}
