import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminProjectDetail extends ConsumerWidget {
  static const routeName = '/admin-project-detail';

  final ProjectModel project;

  const AdminProjectDetail({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar("Detail Project"),
      body: _body(context, ref),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                viewTextField(context, "Project Title", project.name, false),
                viewTextField(context, "Start Date",
                    DateFormat.yMMMEd().format(project.startDate), false),
                viewTextField(context, "End Date",
                    DateFormat.yMMMEd().format(project.endDate), false),
                viewTextField(
                    context, "Project Description", project.description, true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
