import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/screens/admin_report_detail.dart';
import 'package:report_project/admin/view_model/admin_report_rejected_view_model.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _filterDropdown(context, "Project Category", ref),
              _listReportView(ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterDropdown(
      BuildContext context, String fieldLabel, WidgetRef ref) {
    final projects = ref.watch(adminProjectControllerProvider);
    return projects.when(
      data: (data) {
        final projectCategories = [
          const DropdownMenuItem(
            value: 'All',
            child: SizedBox(
              width: 100.0,
              child: Text('All'),
            ),
          ),
          ...data.map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: SizedBox(
                width: 100.0,
                child: Text(e.name),
              ),
            );
          }).toList()
        ];
        return Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 5.0,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 0.0),
                  child: Text(
                    "$fieldLabel : ",
                    style: kHeaderTextStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child:
                      projectCategoryDropdown(context, ref, projectCategories),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Text('Error Happen');
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget projectCategoryDropdown(BuildContext context, WidgetRef ref,
      List<DropdownMenuItem<String>>? items) {
    return DropdownButton(
      value: ref.watch(adminReportRejectedProjectCategorySelectedProvider),
      onChanged: (value) {
        ref
            .read(adminReportRejectedProjectCategorySelectedProvider.notifier)
            .state = value!;
      },
      items: items,
    );
  }

  Widget _listReportView(WidgetRef ref) {
    final reports = ref.watch(adminReportRejectedFutureFilteredList);
    final projects = ref.watch(adminProjectControllerProvider);
    return SizedBox(
      height: 375.0,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        elevation: 5.0,
        child: reports.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                  child: Text('No Data', style: kHeaderTextStyle));
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final report = data[index];
                // final project = projects.asData?.value.firstWhere(
                //     (element) => element.id == data[index].projectId);
                return _reportViewItem(context, report, report.project);
              },
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
      ),
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
                      'Report by : ${report.user?.nickname}', false),
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
