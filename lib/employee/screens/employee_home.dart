import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/models/project_report_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/employee/controllers/employee_controller.dart';
import 'package:report_project/employee/controllers/project_report_controller.dart';
import 'package:report_project/employee/screens/create_report.dart';
import 'package:report_project/employee/screens/detail_report.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class EmployeeHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home_employee_screen';

  const EmployeeHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeEmployeeState();
}

class _HomeEmployeeState extends ConsumerState<EmployeeHomeScreen> {
  late final UserModel employee;

  @override
  void initState() {
    super.initState();
    employee = ref.read(employeeControllerProvider).getCurrentEmployee()!;
    ref.read(projectReportControllerProvider.notifier).getProjectReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("HOME"),
      body: _body(),
      drawer: showDrawer(context, employee),
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
              _listProjectView(),
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
            _menuBarItem(Icons.question_mark, "???", () {}),
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

  Widget _listProjectView() {
    final projectReports = ref.watch(getProjectReportsProvider);
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
            return ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _projectViewItem(data[index]);
                });
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

  Widget _projectViewItem(ProjectReportModel data) {
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
                            data.projectTitle,
                            style: kTitleReportItem,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        reportStatus(data.projectStatus)
                      ],
                    ),
                  ),
                  reportItemContent(data.projectDateTime.toString(), false),
                  reportItemContent(data.projectPosition.toString(), false),
                  reportItemContent(data.projectDesc, true),
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

// Widget _listProjectView() {
//   final getProjectReports = ref.watch(projectReportControllerProvider);
//   return SizedBox(
//     height: MediaQuery.of(context).size.height / 1.5,
//     child: Card(
//       shape: const RoundedRectangleBorder(
//         side: BorderSide(color: Colors.black38),
//         borderRadius: BorderRadius.all(Radius.circular(15.0)),
//       ),
//       elevation: 5.0,
//       child: FutureBuilder(
//         future: getData(),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   '${snapshot.error} occurred',
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               );
//             } else if (snapshot.hasData) {
//               final data = snapshot.data;
//               return ListView.builder(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   itemCount: snapshot.hasData ? snapshot.data!.length : 1,
//                   itemBuilder: (BuildContext context, int index) {
//                     return _projectViewItem(data![index]);
//                   });
//             }
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     ),
//   );
// }

// Widget _projectViewItem(Map<String, dynamic> data) {
//   return Container(
//     margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
//     height: 150.0,
//     child: Card(
//       elevation: 5.0,
//       clipBehavior: Clip.hardEdge,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       child: Material(
//         child: InkWell(
//           onTap: () {
//             Navigator.pushNamed(context, ReportDetail.routeName);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           data['projectTitle'],
//                           style: kTitleReportItem,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       reportStatus(data['projectStatus'])
//                     ],
//                   ),
//                 ),
//                 reportItemContent(data['projectDateTime'], false),
//                 reportItemContent(data['projectLocation'], false),
//                 reportItemContent(data['projectDesc'], true),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
