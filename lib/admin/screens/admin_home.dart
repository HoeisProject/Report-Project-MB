import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_report_controller.dart';
import 'package:report_project/admin/screens/admin_project_home.dart';
import 'package:report_project/admin/widgets/admin_home_filter.dart';
import 'package:report_project/admin/widgets/admin_home_search_bar.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/controller/role_controller.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/admin/screens/admin_detail_report.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/employee/screens/employee_home.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin_home_screen';

  const AdminHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint("Admin Home Screen");
    ref.listen(profileControllerProvider, (previous, next) {
      debugPrint('Admin Home Screen - ref listen profileControllerProvider');
      if (!next.hasValue || next.value == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginRegisterScreen.routeName, (route) => false);
        return;
      }
      final roleController = ref.read(roleControllerProvider.notifier);
      final currentRole = roleController.findById(next.value!.roleId);
      if (currentRole.name != RoleModelNameEnum.admin.name) {
        Navigator.pushNamedAndRemoveUntil(
            context, EmployeeHomeScreen.routeName, (route) => false);
      }
    });

    final admin = ref.watch(profileControllerProvider);
    debugPrint("build scaffold");

    return admin.when(
      data: (data) {
        if (data == null) return Container();
        return Scaffold(
          appBar: customAppbar("HOME"),
          body: _body(),
          drawer: showDrawer(context, ref, data),
        );
      },
      error: (error, stackTrace) {
        return const ErrorScreen(text: 'Admin Home Screen - Call Developer');
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _menuBar(),
              _listProjectView(),
              _searchAndFilter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 15.0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _menuBarItem(Icons.polyline_rounded, 'Project', () {
              Navigator.pushNamed(context, AdminProjectHomeScreen.routeName);
            }),
            _menuBarItem(Icons.assignment, "Employee", () {}),
            _menuBarItem(Icons.question_mark, "Project", () {}),
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

  Widget _searchAndFilter() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: adminHomeSearchBar(context, ref, _searchController),
        ),
        Expanded(
          child: adminHomeFilterMenu(context, ref),
        ),
      ],
    );
  }

  Widget _listProjectView() {
    final projectReports = ref.watch(adminReportControllerProvider);
    final reportStatus = ref.read(reportStatusControllerProvider.notifier);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        elevation: 5.0,
        child: projectReports.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                  child: Text('NO DATA', style: TextStyle(fontSize: 36.0)));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return _projectViewItem(
                  data[index],
                  reportStatus.findIndexById(data[index].id),
                );
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _projectViewItem(ReportModel report, int status) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AdminDetailReportScreen(report: report);
              }));
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
                        reportStatus(status)
                      ],
                    ),
                  ),
                  // TODO
                  // reportItemContent(report.uploadBy.username, false),
                  reportItemContent(
                      DateFormat.yMMMEd().format(DateTime.now()), false),
                  reportItemContent("Project Location", false),
                  reportItemContent(report.description, true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget reportItemContent(String content, bool isDesc) {
    return Flexible(
      flex: isDesc ? 2 : 1,
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

  Widget reportStatus(int status) {
    IconData statusIcon;
    Color iconColor;
    switch (status) {
      case 0:
        statusIcon = Icons.timelapse;
        iconColor = Colors.yellow;
        break;
      case 1:
        statusIcon = Icons.done;
        iconColor = Colors.green;
        break;
      case 2:
        statusIcon = Icons.cancel_outlined;
        iconColor = Colors.red;
        break;
      default:
        statusIcon = Icons.timelapse;
        iconColor = Colors.yellow;
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
