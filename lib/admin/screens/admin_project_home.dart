import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/screens/admin_project_create.dart';
import 'package:report_project/common/widgets/custom_button.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              customButton(context, false, 'Create', Colors.green, () {
                Navigator.pushNamed(
                    context, AdminProjectCreateScreen.routeName);
              }),
              // _searchAndFilter(),
              _listProjectView(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listProjectView(context, WidgetRef ref) {
    final projects = ref.watch(adminProjectControllerProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
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
                return ListTile(
                  title: Text(data[index].name),
                  subtitle: Text(data[index].description),
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
}
