import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/admin/screens/admin_report_detail.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminReportRejectedScreen extends ConsumerWidget {
  static const routeName = 'admin-report-reject';
  const AdminReportRejectedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar('Report Rejected'),
      body: _body(context, ref),
    );
  }

  Widget _body(context, WidgetRef ref) {
    final reports = ref.watch(reportRejectedControllerProvider);
    final projects = ref.watch(adminProjectControllerProvider);
    return reports.when(
      data: (data) {
        if (data.isEmpty) return const Center(child: Text('No Data'));
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final project = projects.asData?.value
                .firstWhere((element) => element.id == data[index].projectId);
            return _reportViewItem(context, data[index], project);
          },
        );
      },
      error: (error, stackTrace) {
        /// TODO after resolve ErrorScreen
        return Container();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _reportViewItem(
    context,
    ReportModel report,
    ProjectModel? project,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      height: 200.0,
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AdminReportDetailScreen.routeName,
                arguments: report,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            report.title,
                            style: kTitleReportItem,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Center(
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 20.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _reportItemContent(
                      'Report by : ${report.userId.nickname}', false),
                  _reportItemContent(
                      DateFormat.yMMMEd().format(DateTime.now()), false),
                  FutureBuilder(
                    future: TranslatePosition(position: report.position)
                        .translatePos(),
                    builder: (context, snapshot) {
                      return _reportItemContent(snapshot.data ?? '-', false);
                    },
                  ),
                  _reportItemContent('From project : ${project?.name}', false),
                  _reportItemContent(report.description, true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _reportItemContent(String content, bool isDesc) {
    return Flexible(
      flex: isDesc ? 3 : 1,
      child: Container(
        margin: const EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: Text(
          content,
          style: kContentReportItem,
          softWrap: true,
          maxLines: isDesc ? 3 : 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
