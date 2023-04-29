import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/controllers/report_media_controller.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailReportScreen extends ConsumerWidget {
  static const routeName = '/report-detail';

  final ReportModel report;

  const DetailReportScreen({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar("Detail Report"),
      body: _body(context, ref),
    );
  }

  Widget _body(context, WidgetRef ref) {
    final reportsMedia = ref.watch(getReportMediaProvider(
      reportId: report.id,
    ));
    return Container(
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
                    return Center(
                      child: Text(
                        '${error.toString()} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
