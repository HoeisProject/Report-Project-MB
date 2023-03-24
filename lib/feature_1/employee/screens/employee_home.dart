import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/feature_1/employee/screens/create_report.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';

import 'detail_report.dart';

class HomeEmployee extends StatefulWidget {
  static const routeName = '/home_employee_screen';

  const HomeEmployee({super.key});

  @override
  State<StatefulWidget> createState() => HomeEmployeeState();
}

class HomeEmployeeState extends State<HomeEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("HOME"),
      body: _body(),
      drawer: showDrawer(context),
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _menuBar(),
            _listProjectView(),
          ],
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
          children: [
            _menuBarItem(Icons.assignment, "Report", () {
              Navigator.pushNamed(context, ReportCreate.routeName);
            }),
            _menuBarItem(Icons.question_mark, "???", () {}),
            _menuBarItem(Icons.question_mark, "???", () {}),
            _menuBarItem(Icons.question_mark, "???", () {}),
            _menuBarItem(Icons.question_mark, "???", () {}),
          ],
        ),
      ),
    );
  }

  Widget _menuBarItem(IconData icon, String label, void Function()? onPressed) {
    return SizedBox(
      height: 75.0,
      width: 75.0,
      child: Card(
        elevation: 5.0,
        child: Material(
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 30.0,
                ), // <-- Icon
                Text(label), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getData() {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return [
          {
            "projectTitle": "first title",
            "projectDateTime": "first title",
            "projectLocation": "first title",
            "projectDesc": "first description",
            "projectStatus": 0,
          },
          {
            "projectTitle": "second title",
            "projectDateTime": "second title",
            "projectLocation": "second title",
            "projectDesc": "second description",
            "projectStatus": 1,
          },
          {
            "projectTitle": "third title",
            "projectDateTime": "third title",
            "projectLocation": "third title",
            "projectDesc": "third description",
            "projectStatus": 3,
          }
        ];
      },
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
        child: FutureBuilder(
          future: getData(),
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

  Widget _projectViewItem(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      height: 100.0,
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, ReportDetail.routeName);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['projectTitle']),
                    Text(data['projectStatus'].toString())
                  ],
                ),
                Text(data['projectDateTime']),
                Text(data['projectLocation']),
                Text(data['projectDesc']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
