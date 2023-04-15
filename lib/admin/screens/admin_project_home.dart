import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/view_model/admin_project_home_view_model.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminProjectHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-project-home';
  const AdminProjectHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminProjectHomeScreenState();
}

class _AdminProjectHomeScreenState
    extends ConsumerState<AdminProjectHomeScreen> {
  final _keyTitle = GlobalKey<FormState>();
  final _keyDesc = GlobalKey<FormState>();

  final _nameCtl = TextEditingController();
  final _descCtl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameCtl.dispose();
    _descCtl.dispose();
  }

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
        appBar: customAppbar("Project Management"),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    final startDate = ref.watch(adminProjectHomeStartDateProvider);
    final endDate = ref.watch(adminProjectHomeEndDateProvider);
    return SingleChildScrollView(
        child: Column(
      children: [
        inputTextField(context, _keyTitle, 'Project Name', _nameCtl,
            TextInputType.text, false, false, 1, (p0) {}),
        inputTextField(context, _keyDesc, "Project Description", _descCtl,
            TextInputType.text, false, false, 6, (p0) {}),
        Text(startDate != null ? startDate.toString() : 'Select Start Date'),
        Text(endDate != null ? endDate.toString() : 'Select End Date'),
        customButton(context, false, 'Start Date', Colors.red, () async {
          final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2024));
          ref.read(adminProjectHomeStartDateProvider.notifier).state =
              pickedDate;
        }),
        customButton(context, false, 'End Date', Colors.red, () async {
          final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2024));
          ref.read(adminProjectHomeEndDateProvider.notifier).state = pickedDate;
        }),
      ],
    ));
  }
}
