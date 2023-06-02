import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/admin/controllers/admin_report_media_controller.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/controller/show_image_full_func_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/show_download_loading_dialog.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminReportDetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-report-detail';

  final ReportModel report;

  const AdminReportDetailScreen({super.key, required this.report});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AdminReportDetailScreenState();
}

class AdminReportDetailScreenState
    extends ConsumerState<AdminReportDetailScreen> {
  bool isLoadingReject = false;
  bool isLoadingApprove = false;

  ReportModel get report => widget.report;

  @override
  Widget build(BuildContext context) {
    widget.report;
    return Scaffold(
      appBar: customAppbar("Detail Report"),
      body: _body(),
    );
  }

  Widget _body() {
    final reportsMedia = ref.watch(getAdminReportMediaProvider(
      reportId: report.id,
    ));
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                viewTextField(context, "Project Title", report.title, false),
                viewTextField(
                    context, "Report by", report.user!.nickname, false),
                viewTextField(context, "Time and Date",
                    DateFormat.yMMMEd().format(report.updatedAt), false),
                ref
                    .watch(translatePositionProvider(position: report.position))
                    .when(
                      data: (data) =>
                          viewTextField(context, 'Location', data, false),
                      error: (error, stackTrace) =>
                          const Text('Not a valid address'),
                      loading: () => const CircularProgressIndicator(),
                    ),
                viewTextField(
                    context, "Project Description", report.description, false),
                reportsMedia.when(
                  data: (data) {
                    final listMediaFilePath =
                        data.map((e) => e.attachment).toList();
                    final listMediaId = data.map((e) => e.id).toList();
                    Future(
                      () {
                        ref
                            .read(
                                reportDetailListMediaFilePathProvider.notifier)
                            .state = listMediaFilePath;
                      },
                    );
                    return viewMediaField(
                      context,
                      "Attach Media",
                      listMediaFilePath,
                      listMediaId,
                    );
                  },
                  error: (error, stackTrace) {
                    return Text('${error.toString()} occurred');
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customButton(context, isLoadingReject, "REJECT", Colors.red,
                        () => _rejectReport(context)),
                    const SizedBox(width: 10.0),
                    customButton(context, isLoadingApprove, "APPROVE",
                        Colors.greenAccent, () => _approveReport(context)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _rejectReport(context) async {
    showLoadingDialog(context);

    final rejectStatusId = ref
        .read(reportStatusControllerProvider.notifier)
        .findIdByName('reject');
    final errMsg = await ref
        .read(adminReportControllerProvider.notifier)
        .updateReportStatus(
          id: report.id,
          reportStatusId: rejectStatusId,
        );
    Navigator.pop(context); // close loading dialog
    if (errMsg.isEmpty) {
      showSnackBar(context, Icons.done, Colors.greenAccent, "Rejection Success",
          Colors.greenAccent);
      Navigator.pop(context);
    } else {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Rejection Failed $errMsg", Colors.red);
    }
  }

  void _approveReport(context) async {
    showLoadingDialog(context);

    final rejectStatusId = ref
        .read(reportStatusControllerProvider.notifier)
        .findIdByName('approve');
    final errMsg = await ref
        .read(adminReportControllerProvider.notifier)
        .updateReportStatus(
          id: report.id,
          reportStatusId: rejectStatusId,
        );
    Navigator.pop(context); // close loading dialog
    if (errMsg.isEmpty) {
      showSnackBar(context, Icons.done, Colors.greenAccent, "Approval Success",
          Colors.greenAccent);
      downloadImages(context);
    } else {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Approval Failed $errMsg", Colors.red);
    }
  }

  void downloadImages(context) async {
    List<String> listMediaPath =
        ref.watch(reportDetailListMediaFilePathProvider);
    Dio dio = Dio();
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

    bool fileError = false;

    for (var mediaPath in listMediaPath) {
      if (fileError) break;
      try {
        String fileName = DateTime.now().toString();
        await dio.download(
          mediaPath,
          '$dirLoc${report.title}_$fileName.jpg',
          onReceiveProgress: (receivedBytes, totalBytes) {
            ref.read(imageDownloadProgressProvider.notifier).state =
                (receivedBytes / totalBytes).toDouble();
            ref.read(imageDownloadTextProvider.notifier).state =
                "Download File : ${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}% ${listMediaPath.indexOf(mediaPath) + 1}/${listMediaPath.length}";
          },
        ).then(
          (value) {
            if (value.statusCode == 200) {
              ref.read(imageDownloadProgressProvider.notifier).state = 0;
              ref.read(imageDownloadTextProvider.notifier).state =
                  "Download File : 0% -/${listMediaPath.length}";
              if ((listMediaPath.indexOf(mediaPath) + 1) ==
                  listMediaPath.length) {
                Navigator.pop(context);
                showSnackBar(context, Icons.done, Colors.greenAccent,
                    "Download Success $dirLoc", Colors.greenAccent);
              }
            } else {
              ref.read(imageDownloadProgressProvider.notifier).state = 0;
              ref.read(imageDownloadTextProvider.notifier).state =
                  "Download File : 0% -/${listMediaPath.length}";
              fileError = true;
              showSnackBar(context, Icons.error_outline, Colors.red,
                  "Download Failed $dirLoc$fileName.jpg", Colors.red);
            }
          },
        );
      } catch (e) {
        debugPrint("error : $e");
        showSnackBar(context, Icons.error_outline, Colors.red,
            "Download Failed", Colors.red);
        break;
      }
    }
  }
}
