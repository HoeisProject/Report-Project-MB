import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/screens/login_register.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/models/report_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/common/utilities/translate_position.dart';
import 'package:report_project/common/widgets/category_dropdown.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/employee/controllers/report_controller.dart';
import 'package:report_project/employee/screens/employee_report_create.dart';
import 'package:report_project/employee/screens/employee_report_detail.dart';
import 'package:report_project/employee/screens/employee_report_home.dart';
import 'package:report_project/employee/screens/user_status_no_upload.dart';
import 'package:report_project/employee/screens/user_status_pending.dart';
import 'package:report_project/employee/screens/user_status_rejected.dart';
import 'package:report_project/employee/view_model/employee_home_view_model.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:report_project/employee/widgets/employee_home_filter.dart';

class EmployeeHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/employee-home';

  const EmployeeHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends ConsumerState<EmployeeHomeScreen> {
  // final _searchController = TextEditingController();

  List<ProjectModel> listProject = [];

  // Availability is important to ensure that information and systems are accessible to authorized users when they need them.
  Widget availability(int status) {
    if (UserStatus.pending.value == status) {
      return const UserStatusPendingScreen();
    }
    if (UserStatus.approve.value == status) return _body();
    if (UserStatus.reject.value == status) {
      return const UserStatusRejectedScreen();
    }
    return const UserStatusNoUploadScreen();
  }

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
          body: availability(data.status),
          drawer: showDrawer(context, ref, data),
        );
      },
      error: (error, stackTrace) {
        return const ErrorScreen(text: 'Employe Home Screen - Call Developer');
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _menuBar(),
            // _searchAndFilter(),
            // _projecCategory(context, ref),

            Expanded(child: _listReportView()),
          ],
        ),
      ),
    );
  }

  Widget _menuBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _menuBarItem(Icons.add_box_outlined, "Add\nReport", () {
              Navigator.pushNamed(
                  context, EmployeeReportCreateScreen.routeName);
            }),
            _menuBarItem(Icons.assignment_outlined, "Manage\nReport", () {
              Navigator.pushNamed(context, EmployeeReportHomeScreen.routeName);
            }),
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
                return const EmployeeHomeFilterMenu();
              });
        },
        icon: const Icon(Icons.filter_list));
  }

  // Widget _searchAndFilter() {
  //   return Row(
  //     children: [
  //       Flexible(
  //         flex: 4,
  //         child: employeeHomeSearchBar(context, ref, _searchController),
  //       ),
  //       Flexible(
  //         child: showFilterMenu(context, ref),
  //       ),
  //     ],
  //   );
  // }

  Widget _projecCategory(context, WidgetRef ref) {
    final projects = ref.watch(adminProjectControllerProvider);

    final projectCategorySelected =
        ref.watch(employeeHomeProjectCategorySelected);
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
          child: categoryDropdown(
            context,
            "Project Category",
            projectCategorySelected,
            projectCategories,
            (value) {
              ref.read(employeeHomeProjectCategorySelected.notifier).state =
                  value ?? '';
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

  Widget _listReportView() {
    final reports = ref.watch(employeeHomeFutureFilteredList);
    // final reports = ref.watch(getReportByProjectProvider(
    //   projectId: ref.watch(employeeHomeProjectCategorySelected),
    //   showOnlyRejected: false,
    // ));
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
                child: Text('NO DATA', style: kHeaderTextStyle));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final report = data[index];
              return _reportViewItem(report);
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

  Widget _reportViewItem(ReportModel report) {
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
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                EmployeeReportDetailScreen.routeName,
                arguments: report,
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
                          report.title,
                          style: kTitleReportItem,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _reportStatus(report.reportStatus?.name ?? '')
                    ],
                  ),
                  _reportItemContent(
                      DateFormat.yMMMEd().format(report.updatedAt), false),
                  ref
                      .watch(
                          translatePositionProvider(position: report.position))
                      .when(
                        data: (data) => _reportItemContent(data, false),
                        error: (error, stackTrace) =>
                            const Text('Not a valid address'),
                        loading: () => const CircularProgressIndicator(),
                      ),
                  _reportItemContent(
                      'From project : ${report.project?.name}', false),
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
    return Container(
      margin: const EdgeInsets.only(top: 2.5, bottom: 2.5),
      child: Text(
        content,
        style: kContentReportItem,
        softWrap: true,
        maxLines: isDesc ? 3 : 1,
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
