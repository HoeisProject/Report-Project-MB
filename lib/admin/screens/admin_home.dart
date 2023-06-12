import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/screens/admin_project_priority.dart';
import 'package:report_project/admin/screens/admin_report_home.dart';
import 'package:report_project/admin/screens/admin_user_home.dart';
import 'package:report_project/admin/screens/admin_project_home.dart';
import 'package:report_project/admin/view_model/admin_home_view_model.dart';
import 'package:report_project/admin/widgets/admin_home_filter.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/admin/screens/admin_report_detail.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/employee/screens/employee_home.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-home';

  const AdminHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  // final _searchController = TextEditingController();

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

      final currentRole = next.value!.role!;
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
        return const Center(
          child: CircularProgressIndicator(),
        );
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
              // _searchAndFilter(),
              _listReportView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _menuBarItem(Icons.work_outline, 'Project', () {
              Navigator.pushNamed(context, AdminProjectHomeScreen.routeName);
            }),
            _menuBarItem(Icons.work_history_outlined, "Project\nPriority", () {
              Navigator.pushNamed(
                  context, AdminProjectPriorityScreen.routeName);
            }),
            _menuBarItem(Icons.insert_drive_file_outlined, "Manage\nReport",
                () {
              Navigator.pushNamed(context, AdminReportHomeScreen.routeName);
            }),
            _menuBarItem(Icons.supervised_user_circle_outlined, "Manage\nUser",
                () {
              Navigator.pushNamed(context, AdminUserHomeScreen.routeName);
            }),
            // _menuBarItem(Icons.cancel_outlined, "Rejected\nReport", () {
            //   Navigator.pushNamed(context, AdminReportRejectedScreen.routeName);
            // }),
          ],
        ),
      ),
    );
  }

  Widget _menuBarItem(IconData icon, String label, void Function()? onPressed) {
    return SizedBox(
      height: 100.0,
      width: 85.0,
      child: Card(
        elevation: 5.0,
        child: Material(
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Icon(
                    icon,
                    size: 35.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showFilterMenu(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () {
          debugPrint("menu out");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AdminHomeFilterMenu();
            },
          );
        },
        icon: const Icon(Icons.filter_list));
  }

  // Widget _searchAndFilter() {
  //   return Row(
  //     children: [
  //       Flexible(
  //         flex: 4,
  //         child: adminHomeSearchBar(context, ref, _searchController),
  //       ),
  //       Flexible(
  //         child: showFilterMenu(context, ref),
  //       ),
  //     ],
  //   );
  // }

  Widget _listReportView() {
    final reports = ref.watch(adminHomeFutureFilteredList);
    return SizedBox(
      // height: 375.0,
      height: MediaQuery.of(context).size.height * 0.70,
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
                  child: Text('NO DATA', style: kHeaderTextStyle));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final report = data[index];
                return _reportViewItem(
                  report,
                  report.project,
                  report.reportStatus!.name,
                );
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
    ReportModel report,
    ProjectModel? project,
    String status,
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
                        _reportStatus(status)
                      ],
                    ),
                  ),
                  _reportItemContent(
                      'Report by : ${report.user?.nickname}', false),
                  _reportItemContent(
                      DateFormat.yMMMEd().format(DateTime.now()), false),
                  ref
                      .watch(
                          translatePositionProvider(position: report.position))
                      .when(
                        data: (data) => _reportItemContent(data, false),
                        error: (error, stackTrace) =>
                            const Text('Not a valid address'),
                        loading: () => const CircularProgressIndicator(),
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
