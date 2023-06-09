import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/common/widgets/show_image_full_func.dart';

Widget viewImageField(
    BuildContext context, String fieldLabel, String? mediaFilePath, String id) {
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
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowImageFullFunc(
                            listMediaFilePath: [mediaFilePath],
                            id: id,
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: mediaFilePath,
                      child: Image.network(mediaFilePath,
                          loadingBuilder: (context, child, event) {
                        if (event == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              value: event.cumulativeBytesLoaded /
                                  (event.expectedTotalBytes ?? 1),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                : const Icon(Icons.add_a_photo, size: 50.0),
          ),
        ),
      ],
    ),
  );
}
