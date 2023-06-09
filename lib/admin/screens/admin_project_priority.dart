import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:report_project/admin/controllers/admin_project_priority_controller.dart';
import 'package:report_project/admin/screens/admin_project_detail.dart';
import 'package:report_project/admin/view_model/admin_project_priority_view_model.dart';
import 'package:report_project/common/models/project_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/category_dropdown.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminProjectPriorityScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-project-priority';
  const AdminProjectPriorityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminProjectPriorityScreenState();
}

class _AdminProjectPriorityScreenState
    extends ConsumerState<AdminProjectPriorityScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: customAppbar("Project Priority"),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _timeSpanDropdown(),
            _moneyEstimateDropdown(),
            _manpowerDropdown(),
            _materialFeasibilityDropdown(),
            Container(
              constraints: const BoxConstraints(minHeight: 300),
              child: _listProjectView(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeSpanDropdown() {
    final timeSpanList = ref.watch(getTimeSpanProvider);
    final timeSpanSelected = ref.watch(adminProjectPriorityTimeSpanSelected);
    return timeSpanList.when(
      data: (data) {
        final categories = [
          const DropdownMenuItem(value: '', child: Text('Choose Time Span')),
          ...data
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text('${e.min} - ${e.max} working days'),
                  ))
              .toList()
        ];
        return Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 5,
          child: categoryDropdown(
            context,
            "Time Span Category",
            timeSpanSelected,
            categories,
            (value) {
              ref
                  .read(adminProjectPriorityTimeSpanSelected.notifier)
                  .update((state) => value ?? '');
            },
            const Icon(Icons.keyboard_arrow_down),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error Time Span ...'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _moneyEstimateDropdown() {
    final moneyEstimateList = ref.watch(getMoneyEstimateProvider);
    final moneyEstimateSelected =
        ref.watch(adminProjectPriorityMoneyEstimateSelected);
    return moneyEstimateList.when(
      data: (data) {
        final categories = [
          const DropdownMenuItem(
              value: '', child: Text('Choose Money Estimate')),
          ...data
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text('Rp.${e.min} - Rp.${e.max}'),
                  ))
              .toList()
        ];
        return Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 5,
          child: categoryDropdown(
            context,
            "Money Estimate Category",
            moneyEstimateSelected,
            categories,
            (value) {
              ref
                  .read(adminProjectPriorityMoneyEstimateSelected.notifier)
                  .update((state) => value ?? '');
            },
            const Icon(Icons.keyboard_arrow_down),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error Money Estimate ...'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _manpowerDropdown() {
    final manpowerList = ref.watch(getManpowerProvider);
    final manpowerSelected = ref.watch(adminProjectPriorityManpowerSelected);
    return manpowerList.when(
      data: (data) {
        final categories = [
          const DropdownMenuItem(value: '', child: Text('Choose Time Span')),
          ...data
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text('${e.min} - ${e.max} manpower'),
                  ))
              .toList()
        ];
        return Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 5,
          child: categoryDropdown(
            context,
            "Manpower Category",
            manpowerSelected,
            categories,
            (value) {
              ref
                  .read(adminProjectPriorityManpowerSelected.notifier)
                  .update((state) => value ?? '');
            },
            const Icon(Icons.keyboard_arrow_down),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error Manpower ...'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _materialFeasibilityDropdown() {
    final materialFeasibilityList = ref.watch(getMaterialFeasibilityProvider);
    final materialFeasibilitySelected =
        ref.watch(adminProjectPriorityMaterialFeasibilitySelected);
    return materialFeasibilityList.when(
      data: (data) {
        final categories = [
          const DropdownMenuItem(
              value: '', child: Text('Choose Material Feasibility')),
          ...data
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.description),
                  ))
              .toList()
        ];
        return Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 5,
          child: categoryDropdown(
            context,
            "Material Feasibility Category",
            materialFeasibilitySelected,
            categories,
            (value) {
              ref
                  .read(
                      adminProjectPriorityMaterialFeasibilitySelected.notifier)
                  .update((state) => value ?? '');
            },
            const Icon(Icons.keyboard_arrow_down),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error Material Feasibility ...'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listProjectView(context, WidgetRef ref) {
    // final projects = ref.watch(adminProjectControllerProvider);
    final projects = ref.watch(calculateProjectPriorityProvider(
      timeSpan: ref.watch(adminProjectPriorityTimeSpanSelected),
      moneyEstimate: ref.watch(adminProjectPriorityMoneyEstimateSelected),
      manpower: ref.watch(adminProjectPriorityManpowerSelected),
      materialFeasibility:
          ref.watch(adminProjectPriorityMaterialFeasibilitySelected),
    ));
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 5.0,
      semanticContainer: false,
      child: projects.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
                child: Text('NO DATA', style: TextStyle(fontSize: 36.0)));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _projectViewItem(context, data[index].project!);
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _projectViewItem(BuildContext context, ProjectModel project) {
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
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AdminProjectDetail.routeName,
              arguments: project,
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
                        project.name,
                        style: kTitleReportItem,
                      ),
                    ),
                  ],
                ),
                _projectItemContentWithIcon(
                  Icons.calendar_month,
                  "Start : ${DateFormat.yMMMEd().format(project.startDate)}",
                ),
                _projectItemContentWithIcon(
                  Icons.calendar_month,
                  "end   : ${DateFormat.yMMMEd().format(project.endDate)}",
                ),
                _projectItemContent(project.description, true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _projectItemContent(String content, bool isDesc) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Text(
        content,
        style: kContentReportItem,
        softWrap: true,
        maxLines: isDesc ? 3 : 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _projectItemContentWithIcon(
    IconData icon,
    String content,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            content,
            style: kContentReportItem,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
