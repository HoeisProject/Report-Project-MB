import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

Widget viewImageField(
    BuildContext context, String fieldLabel, String? mediaFilePath) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: SizedBox(
      width: 75.0,
      height: 75.0,
      child: mediaFilePath != null
          ? PhotoView(
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
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
  );
}
