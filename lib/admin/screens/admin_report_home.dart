import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/view_model/report_home_view_model.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:report_project/employee/widgets/project_category_dropdown.dart';

class AdminReportHome extends ConsumerWidget {
  static const routeName = '/admin-report-home';
  const AdminReportHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar('Report Management'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _projecCategory(context, ref),
              _listReportView(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projecCategory(context, WidgetRef ref) {
    final projects = ref.watch(adminProjectControllerProvider);

    final projectCategorySelected =
        ref.watch(reportHomeProjectCategorySelectedProvider);
    return projects.when(
      data: (data) {
        final projectCategories = [
          const DropdownMenuItem(
            value: '',
            child: Text('Choose Category'),
          ),
          ...data.map((e) {
            return DropdownMenuItem(value: e.id, child: Text(e.name));
          }).toList()
        ];
        return projectCategoryDropdown(
          context,
          "Project Category",
          projectCategorySelected,
          projectCategories,
          (value) {
            ref.read(reportHomeProjectCategorySelectedProvider.notifier).state =
                value ?? '';
          },
          const Icon(Icons.keyboard_arrow_down),
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

  Widget _listReportView(context, WidgetRef ref) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      elevation: 5.0,
    );
  }
}
