import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/admin/controllers/admin_report_media_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/report_status_model.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminDetailReportScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-report-detail';

  final ReportModel report;

  const AdminDetailReportScreen({super.key, required this.report});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AdminDetailReportScreenState();
}

class AdminDetailReportScreenState
    extends ConsumerState<AdminDetailReportScreen> {
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
                viewTextField(context, "Project Title", report.title),
                viewTextField(context, "Report by", "Report by"),
                viewTextField(context, "Time and Date",
                    DateFormat.yMMMEd().format(report.updatedAt)),
                FutureBuilder(
                  future: TranslatePosition(position: report.position)
                      .translatePos(),
                  builder: (context, snapshot) {
                    return viewTextField(
                        context, "Location", snapshot.data ?? '-');
                  },
                ),
                viewTextField(
                    context, "Project Description", report.description),
                reportsMedia.when(
                  data: (data) {
                    final listMediaFilePath =
                        data.map((e) => e.reportAttachment).toList();
                    return viewMediaField(
                      context,
                      "Attach Media",
                      listMediaFilePath,
                    );
                  },
                  error: (error, stackTrace) {
                    return Text('${error.toString()} occured');
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton(context, isLoadingReject, "REJECT", Colors.red,
                        rejectReport),
                    customButton(context, isLoadingApprove, "APPROVE",
                        Colors.greenAccent, approveReport)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void rejectReport() {
    showLoadingDialog(context);
    ref
        .read(adminReportControllerProvider.notifier)
        .updateReportStatus(
          id: report.id,
          status: ReportStatusEnum.reject.index,
        )
        .then((value) {
      Navigator.pop(context);
      if (value) {
        showSnackBar(context, Icons.done, Colors.greenAccent,
            "Rejection Success", Colors.greenAccent);
        Navigator.pop(context);
      } else {
        showSnackBar(context, Icons.error_outline, Colors.red,
            "Rejection Failed", Colors.red);
      }
    });
  }

  void approveReport() {
    showLoadingDialog(context);
    ref
        .read(adminReportControllerProvider.notifier)
        .updateReportStatus(
          id: report.id,
          status: ReportStatusEnum.approve.index,
        )
        .then((value) {
      Navigator.pop(context);
      if (value) {
        showSnackBar(context, Icons.done, Colors.greenAccent,
            "Approval Success", Colors.greenAccent);
        Navigator.pop(context);
      } else {
        showSnackBar(context, Icons.error_outline, Colors.red,
            "Approval Failed", Colors.red);
      }
    });
  }
}
