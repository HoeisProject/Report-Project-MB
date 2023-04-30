import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/common/controller/report_status_controller.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/employee/screens/create_report.dart';
import 'package:report_project/employee/screens/detail_report.dart';
import 'package:report_project/employee/screens/not_verified.dart';
import 'package:report_project/employee/view_model/employee_home_view_model.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:report_project/employee/widgets/employee_home_filter.dart';
import 'package:report_project/employee/widgets/employee_home_search_bar.dart';

class EmployeeHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home-employee';

  const EmployeeHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends ConsumerState<EmployeeHomeScreen> {
  final _searchController = TextEditingController();

  List<ProjectModel> listProject = [];

  @override
  Widget build(BuildContext context) {
    debugPrint("Employee Home Screen");

    ref.listen(profileControllerProvider, (previous, next) {
      debugPrint('Employee Home Screen - ref listen profileControllerProvider');
      if (!next.hasValue || next.value == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginRegisterScreen.routeName, (route) => false);
      }
    });

    final employee = ref.watch(profileControllerProvider);
    debugPrint('build scaffold');

    return employee.when(
      data: (data) {
        if (data == null) return Container();
        return Scaffold(
          appBar: customAppbar("HOME"),
          body: data.isUserVerified ? _body() : const NotVerifiedScreen(),
          drawer: showDrawer(context, ref, data),
        );
      },
      error: (error, stackTrace) {
        return const ErrorScreen(text: 'Employe Home Screen - Call Developer');
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
            _menuBarItem(Icons.assignment, "Report", () {
              Navigator.pushNamed(context, CreateReportScreen.routeName);
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
                return const EmployeeHomeFilterMenu();
              });
        },
        icon: const Icon(Icons.filter_list));
  }

  Widget _searchAndFilter() {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: employeeHomeSearchBar(context, ref, _searchController),
        ),
        Flexible(
          child: showFilterMenu(context, ref),
        ),
      ],
    );
  }

  Widget _listReportView() {
    final reports = ref.watch(employeeHomeFutureFilteredList);
    final reportStatus = ref.read(reportStatusControllerProvider.notifier);
    final projects = ref.watch(adminProjectControllerProvider);
    return SizedBox(
      height: 425.0,
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
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final report = data[index];
                final project = projects.asData?.value
                    .firstWhere((element) => element.id == report.projectId);
                return _reportViewItem(
                  report,
                  project,
                  reportStatus.findIndexById(report.id),
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

  Widget _reportViewItem(ReportModel data, ProjectModel? project, int status) {
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
                DetailReportScreen.routeName,
                arguments: data,
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
                            data.title,
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
                      DateFormat.yMMMEd().format(data.updatedAt), false),
                  FutureBuilder(
                    future: TranslatePosition(position: data.position)
                        .translatePos(),
                    builder: (context, snapshot) {
                      return _reportItemContent(snapshot.data ?? '-', false);
                    },
                  ),
                  _reportItemContent('From Project: ${project?.name}', false),
                  _reportItemContent(data.description, true),
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

  Widget _reportStatus(int status) {
    IconData? statusIcon;
    Color? iconColor;
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
    ));
  }
}
