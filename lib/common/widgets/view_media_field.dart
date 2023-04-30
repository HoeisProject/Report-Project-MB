import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/show_image_full_func.dart';

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
              return _attachMediaItem(
                context,
                listMediaFilePath,
                listMediaFilePath[index],
                index,
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _attachMediaItem(
  BuildContext context,
  List<String?> listMediaFilePath,
  String? mediaFilePath,
  int index,
) {
  return SizedBox(
    width: 75.0,
    height: 75.0,
    child: mediaFilePath != null
        ? InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowImageFullFunc(
                    listMediaFilePath: listMediaFilePath,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: index,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            },
            child: Hero(
              tag: mediaFilePath,
              child: Image.network(
                mediaFilePath,
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
                },
              ),
            ),
          )
        : const Icon(Icons.add_a_photo, size: 50.0),
  );
}
