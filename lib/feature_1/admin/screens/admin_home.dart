import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/show_drawer.dart';
import 'package:report_project/feature_1/admin/screens/admin_detail_report.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/admin_home_screen';

  const AdminHome({super.key});

  @override
  State<StatefulWidget> createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHome> {
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
          children: [
            _listProjectView(),
          ],
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
              Navigator.pushNamed(context, AdminDetailReport.routeName);
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
