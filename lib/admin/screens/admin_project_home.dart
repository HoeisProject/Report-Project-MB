import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/screens/admin_project_create.dart';
import 'package:report_project/admin/screens/admin_project_detail.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/styles/constant.dart';
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
      margin: const EdgeInsets.only(top: 20.0, bottom: 15.0),
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
    return SizedBox(
      height: 425,
      child: Card(
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
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final project = data[index];
                return _projectViewItem(context, project);
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
      ),
    );
  }

  Widget _projectViewItem(BuildContext context, ProjectModel data) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      height: 150.0,
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
                AdminProjectDetail.routeName,
                arguments: data,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _projectItemContent(null, data.name, false),
                  _projectItemContent(
                      Icons.calendar_month,
                      "Start : ${DateFormat.yMMMEd().format(data.startDate)}",
                      false),
                  _projectItemContent(
                      Icons.calendar_month,
                      "end   : ${DateFormat.yMMMEd().format(data.endDate)}",
                      false),
                  _projectItemContent(null, data.description, true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectItemContent(IconData? icon, String content, bool isDesc) {
    return Flexible(
      flex: isDesc ? 2 : 1,
      child: Container(
        margin: const EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: ListTile(
          leading: icon == null ? null : Icon(icon),
          title: Text(
            content,
            style: kContentReportItem,
            softWrap: true,
            maxLines: isDesc ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
