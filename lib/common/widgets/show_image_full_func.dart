import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:report_project/common/controller/show_image_full_func_controller.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/common/widgets/show_download_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';

class ShowImageFullFunc extends ConsumerStatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final String id;
  final List<String?> listMediaFilePath;
  final Axis scrollDirection;

  ShowImageFullFunc({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.id,
    required this.listMediaFilePath,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowImageFullFuncState();
}

class _ShowImageFullFuncState extends ConsumerState<ShowImageFullFunc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.listMediaFilePath.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: (page) {
                ref.read(switchImageFullFuncProvider.notifier).state = page;
              },
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        downloadImage(context);
                      },
                      icon: Icon(
                        Icons.download,
                        size: 25.0,
                        color: ConstColor(context).getConstColor(
                            ConstColorEnum.kOutlineBorderColor.name),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 25.0,
                        color: ConstColor(context).getConstColor(
                            ConstColorEnum.kOutlineBorderColor.name),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void downloadImage(context) async {
    int pagePosition = ref.watch(switchImageFullFuncProvider);
    Dio dio = Dio();
    String fileName = DateTime.now().toString();
    String dirLoc = "";

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const ShowDownloadLoadingDialog();
      },
    );
    if (Platform.isAndroid) {
      dirLoc = "/storage/emulated/0/Download/";
      bool dirDownloadExists = await Directory(dirLoc).exists();
      if (dirDownloadExists) {
        dirLoc = "/storage/emulated/0/Download/";
      } else {
        dirLoc = "/storage/emulated/0/Downloads/";
      }
      debugPrint("dirPath 1 : $dirLoc");
    }
    try {
      dio.download(
        widget.listMediaFilePath[pagePosition]!,
        '$dirLoc$fileName.jpg',
        onReceiveProgress: (receivedBytes, totalBytes) {
          ref.read(imageDownloadProgressProvider.notifier).state =
              (receivedBytes / totalBytes).toDouble();
          ref.read(imageDownloadTextProvider.notifier).state =
              "Download File : ${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
        },
      ).then((value) {
        if (value.statusCode == 200) {
          ref.read(imageDownloadProgressProvider.notifier).state = 0;
          ref.read(imageDownloadTextProvider.notifier).state =
              "Download File : 0%";
          Navigator.pop(context);
          showSnackBar(context, Icons.done, Colors.greenAccent,
              "Download Success $dirLoc$fileName.jpg", Colors.greenAccent);
          debugPrint("file : $dirLoc$fileName.jpg");
        } else {
          ref.read(imageDownloadProgressProvider.notifier).state = 0;
          ref.read(imageDownloadTextProvider.notifier).state =
              "Download File : 0%";
          Navigator.pop(context);
          showSnackBar(context, Icons.error_outline, Colors.red,
              "Download Failed $dirLoc$fileName.jpg", Colors.red);
        }
      });
    } catch (e) {
      ref.read(imageDownloadProgressProvider.notifier).state = 0;
      ref.read(imageDownloadTextProvider.notifier).state = "Download File : 0%";
      debugPrint("error : $e");
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Download Failed $dirLoc$fileName.jpg", Colors.red);
    }
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.image_not_supported),
        );
      },
      imageProvider: NetworkImage(widget.listMediaFilePath[index]!),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: widget.id),
    );
  }
}
