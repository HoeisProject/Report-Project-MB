import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/admin/screens/admin_report_detail.dart';
import 'package:report_project/admin/view_model/admin_report_home_view_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:report_project/employee/widgets/project_category_dropdown.dart';

class AdminReportHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-report-home';
  const AdminReportHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminReportHomeScreenState();
}

class _AdminReportHomeScreenState extends ConsumerState<AdminReportHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('Report Management'),
      body: _body(context, ref),
    );
  }

  Widget _body(context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _projecCategory(context, ref),
            Expanded(child: _listReportView(context, ref)),
          ],
        ),
      ),
    );
  }

  Widget _projecCategory(context, WidgetRef ref) {
    final projects = ref.watch(adminProjectControllerProvider);

    final projectCategorySelected =
        ref.watch(adminReportHomeProjectCategorySelectedProvider);
    return projects.when(
      data: (data) {
        final projectCategories = [
          const DropdownMenuItem(
            value: '',
            child: Text('Choose Project'),
          ),
          ...data.map((e) {
            return DropdownMenuItem(value: e.id, child: Text(e.name));
          }).toList()
        ];
        return Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 5,
          child: projectCategoryDropdown(
            context,
            "Project Category",
            projectCategorySelected,
            projectCategories,
            (value) {
              ref
                  .read(adminReportHomeProjectCategorySelectedProvider.notifier)
                  .state = value ?? '';
            },
            const Icon(Icons.keyboard_arrow_down),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error Happen'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listReportView(context, WidgetRef ref) {
    final reports = ref.watch(getAdminReportByProjectProvider(
      projectId: ref.watch(adminReportHomeProjectCategorySelectedProvider),
      showOnlyRejected: false,
    ));
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 5.0,
      child: reports.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
                child: Text('NO DATA', style: TextStyle(fontSize: 36.0)));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _reportViewItem(context, data[index], ref);
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _reportViewItem(
    context,
    ReportModel report,
    WidgetRef ref,
  ) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AdminReportDetailScreen.routeName,
              arguments: report,
            ).then((value) {
              ref
                  .read(adminReportHomeProjectCategorySelectedProvider.notifier)
                  .update((state) => '');
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        report.title,
                        style: kTitleReportItem,
                      ),
                    ),
                    _reportStatus(report.reportStatus?.name ?? ''),
                  ],
                ),
                _reportItemContent(
                    'Report By : ${report.user?.nickname}', false),
                ref.watch(translatePositionProvider(position: '')).when(
                      data: (data) => _reportItemContent(data, false),
                      error: (_, __) => const Text('Not a valid address'),
                      loading: () => const CircularProgressIndicator(),
                    ),
                _reportItemContent(report.description, false)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _reportItemContent(String content, bool isDesc) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Text(
        content,
        style: kContentReportItem,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _reportStatus(String status) {
    IconData statusIcon;
    Color iconColor;
    switch (status) {
      case 'pending':
        statusIcon = Icons.timelapse;
        iconColor = Colors.yellow;
        break;
      case 'approve':
        statusIcon = Icons.done;
        iconColor = Colors.green;
        break;
      case 'reject':
        statusIcon = Icons.cancel_outlined;
        iconColor = Colors.red;
        break;
      default:
        statusIcon = Icons.error;
        iconColor = Colors.blue;
        break;
    }
    return Center(
      child: Icon(
        statusIcon,
        size: 20.0,
        color: iconColor,
      ),
    );
  }
}
