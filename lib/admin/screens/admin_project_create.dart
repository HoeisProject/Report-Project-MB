import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/view_model/admin_project_create_view_model.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminProjectCreateScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-project-create';
  const AdminProjectCreateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminProjectCreateScreen();
}

class _AdminProjectCreateScreen
    extends ConsumerState<AdminProjectCreateScreen> {
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

  void submit(context) async {
    final startDate = ref.read(adminProjectCreateStartDateProvider);
    final endDate = ref.read(adminProjectCreateEndDateProvider);
    ref.read(adminProjectCreateIsLoadingProvider.notifier).state = true;
    if (_nameCtl.text.isEmpty ||
        _descCtl.text.isEmpty ||
        startDate == null ||
        endDate == null) {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Fill the requirement ", Colors.red);
    } else {
      final isSuccess =
          await ref.read(adminProjectControllerProvider.notifier).createProject(
                name: _nameCtl.text.trim(),
                description: _descCtl.text.trim(),
                startDate: startDate,
                endDate: endDate,
              );
      if (isSuccess) {
        showSnackBar(context, Icons.error_outline, Colors.blue,
            'Success Create Project', Colors.blue);
        Navigator.pop(context);
        return;
      }
      showSnackBar(context, Icons.error_outline, Colors.red,
          'Failed Create Project', Colors.red);
    }
    ref.read(adminProjectCreateIsLoadingProvider.notifier).state = false;
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
        appBar: customAppbar("Project Create"),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    final startDate = ref.watch(adminProjectCreateStartDateProvider);
    final endDate = ref.watch(adminProjectCreateEndDateProvider);
    final isLoading = ref.watch(adminProjectCreateIsLoadingProvider);
    return SingleChildScrollView(
        child: Column(
      children: [
        inputTextField(context, _keyTitle, 'Project Name', _nameCtl,
            TextInputType.text, false, false, 1, (p0) {}),
        inputTextField(context, _keyDesc, "Project Description", _descCtl,
            TextInputType.text, false, false, 4, (p0) {}),
        Text(startDate != null ? startDate.toString() : 'Select Start Date'),
        Text(endDate != null ? endDate.toString() : 'Select End Date'),
        customButton(context, isLoading, 'Start Date', Colors.red, () async {
          FocusScope.of(context).unfocus();
          final pickedDate = await showDatePicker(
              context: context,
              initialDate: startDate ?? DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2024));
          ref.read(adminProjectCreateStartDateProvider.notifier).state =
              pickedDate;
        }),
        customButton(context, isLoading, 'End Date', Colors.red, () async {
          FocusScope.of(context).unfocus();
          final pickedDate = await showDatePicker(
              context: context,
              initialDate: endDate ?? DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2024));
          ref.read(adminProjectCreateEndDateProvider.notifier).state =
              pickedDate;
        }),
        customButton(
            context, false, 'Create', Colors.yellow, () => submit(context))
      ],
    ));
  }
}
