import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/feature_1/admin/screens/admin_detail_report.dart';
import 'package:report_project/feature_1/admin/services/admin_service.dart';
import 'package:report_project/feature_1/auth/services/profile_service.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/admin_home_screen';

  const AdminHome({super.key});

  @override
  State<StatefulWidget> createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHome> {
  Future<List<ParseObject>>? getReportList;
  ParseUser? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReportList = AdminService().getReports();
    ProfileService().getCurrentUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("HOME"),
      body: _body(),
      drawer: showDrawer(context, user),
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
              _listProjectView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listProjectView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        elevation: 5.0,
        child: FutureBuilder<List<ParseObject>>(
          initialData: const [],
          future: getReportList,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('NO DATA', style: TextStyle(fontSize: 36.0)),
                  );
                }
                final data = snapshot.data;
                return ListView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemCount: snapshot.hasData ? snapshot.data!.length : 1,
                    itemBuilder: (BuildContext context, int index) {
                      return _projectViewItem(data![index]);
                    });
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _projectViewItem(ParseObject data) {
    String? projectTitle = data.get<String>('projectTitle');
    DateTime? projectDateTime = data.get<DateTime>('projectDateTime');
    ParseGeoPoint? projectGeoPoint = data.get<ParseGeoPoint>('projectPosition');
    String? projectDesc = data.get<String>('projectDesc');
    ParseUser? uploadBy = data.get<ParseUser>('uploadBy');
    int? projectStatus = data.get<int>('projectStatus');

    List<Placemark> placeMarks = [];

    placemarkFromCoordinates(
            projectGeoPoint!.latitude, projectGeoPoint.longitude)
        .then((value) {
      placeMarks = value;
    });

    Placemark place = placeMarks[0];

    String locationAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

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
              Navigator.pushNamed(context, AdminDetailReport.routeName);
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
                            projectTitle ?? "Project Title",
                            style: kTitleReportItem,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        reportStatus(projectStatus?.toInt() ?? 0)
                      ],
                    ),
                  ),
                  reportItemContent(uploadBy?.username ?? "username", false),
                  reportItemContent(
                      DateFormat.yMMMEd()
                          .format(projectDateTime ?? DateTime.now()),
                      false),
                  reportItemContent(locationAddress, false),
                  reportItemContent(projectDesc ?? "Project Description", true),
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
