import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_priority_controller.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

final adminProjectDetailIsShowDetailPriority =
    StateProvider.autoDispose<bool>((ref) {
  return false;
});

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
    final projectPriority = ref.watch(findProjectPriorityByProjectIdProvider(
      projectId: project.id,
    ));
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
                    context, "Project Description", project.description, false),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Show Detail Priority',
                          style: kHeaderTextStyle,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(adminProjectDetailIsShowDetailPriority
                                  .notifier)
                              .update((state) => !state);
                        },
                        icon: ref.watch(adminProjectDetailIsShowDetailPriority)
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
                projectPriority.when(
                  data: (data) {
                    if (data == null) {
                      return viewTextField(
                          context, 'No Detail Provided', '', false);
                    }
                    return Visibility(
                      visible:
                          ref.watch(adminProjectDetailIsShowDetailPriority),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            viewTextField(
                              context,
                              "Time Span",
                              '${data.timeSpan.min} - ${data.timeSpan.max} working days',
                              false,
                            ),
                            viewTextField(
                              context,
                              "Money Estimate",
                              'Rp.${data.moneyEstimate.min} - Rp.${data.moneyEstimate.max}',
                              false,
                            ),
                            viewTextField(
                              context,
                              "Manpower",
                              '${data.manpower.min} - ${data.manpower.max} manpower',
                              false,
                            ),
                            viewTextField(
                              context,
                              "Material Feasibility",
                              data.materialFeasibility.description,
                              false,
                            ),
                          ]),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                        child: Text('Error Project Priority Detail'));
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
