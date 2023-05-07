import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/screens/admin_user_home.dart';
import 'package:report_project/admin/screens/admin_project_home.dart';
import 'package:report_project/admin/view_model/admin_home_view_model.dart';
import 'package:report_project/admin/widgets/admin_home_filter.dart';
import 'package:report_project/admin/widgets/admin_home_search_bar.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/controller/role_controller.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/styles/constant.dart';
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
              _searchAndFilter(),
              _listReportView(),
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
            _menuBarItem(Icons.work_outline, 'Project', () {
              Navigator.pushNamed(context, AdminProjectHomeScreen.routeName);
            }),
            _menuBarItem(Icons.supervised_user_circle_outlined, "User", () {
              Navigator.pushNamed(context, AdminUserHomeScreen.routeName);
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

  Widget _searchAndFilter() {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: adminHomeSearchBar(context, ref, _searchController),
        ),
        Flexible(
          child: showFilterMenu(context, ref),
        ),
      ],
    );
  }

  Widget _listReportView() {
    final reports = ref.watch(adminHomeFutureFilteredList);
    final reportStatus = ref.read(reportStatusControllerProvider.notifier);
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
                  child: Text('NO DATA', style: kHeaderTextStyle));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final reports = data[index];
                final project = projects.asData?.value
                    .firstWhere((element) => element.id == reports.projectId);
                return _reportViewItem(
                  reports,
                  project,
                  reportStatus.findIndexById(reports.reportStatusId),
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

  Widget _reportViewItem(
      ReportModel report, ProjectModel? project, int status) {
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
                        reportStatus(status)
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
