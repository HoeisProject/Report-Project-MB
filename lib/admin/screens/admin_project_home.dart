import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/screens/admin_project_create.dart';
import 'package:report_project/admin/screens/admin_project_detail.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminProjectHomeScreen extends ConsumerWidget {
  static const routeName = '/admin-project-home';

  const AdminProjectHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar("Project Management"),
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
            _menuBar(context),
            Expanded(child: _listProjectView(context, ref)),
          ],
        ),
      ),
    );
  }

  Widget _menuBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _menuBarItem(Icons.add_box_outlined, "Create", () {
              Navigator.pushNamed(context, AdminProjectCreateScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }

  Widget _menuBarItem(IconData icon, String label, void Function()? onPressed) {
    return SizedBox(
      height: 85.0,
      width: 85.0,
      child: Card(
        elevation: 5.0,
        child: Material(
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  icon,
                  size: 35.0,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listProjectView(context, WidgetRef ref) {
    final projects = ref.watch(adminProjectControllerProvider);
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 5.0,
      child: projects.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
                child: Text('NO DATA', style: TextStyle(fontSize: 36.0)));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _projectViewItem(context, data[index]);
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
              child: Text(
            '${error.toString()} occurred',
            style: const TextStyle(fontSize: 18),
          ));
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _projectViewItem(BuildContext context, ProjectModel project) {
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
              AdminProjectDetail.routeName,
              arguments: project,
            );
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
                        project.name,
                        style: kTitleReportItem,
                      ),
                    ),
                  ],
                ),
                _projectItemContentWithIcon(
                  Icons.calendar_month,
                  "Start : ${DateFormat.yMMMEd().format(project.startDate)}",
                ),
                _projectItemContentWithIcon(
                  Icons.calendar_month,
                  "end   : ${DateFormat.yMMMEd().format(project.endDate)}",
                ),
                _projectItemContent(project.description, true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectItemContent(String content, bool isDesc) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Text(
        content,
        style: kContentReportItem,
        softWrap: true,
        maxLines: isDesc ? 3 : 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _projectItemContentWithIcon(
    IconData icon,
    String content,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            content,
            style: kContentReportItem,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
