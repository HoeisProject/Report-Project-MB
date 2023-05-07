import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/view_model/admin_project_create_view_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
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
  void initState() {
    super.initState();
    _getInternetTime();
  }

  @override
  void dispose() {
    super.dispose();
    _nameCtl.dispose();
    _descCtl.dispose();
  }

  Future<void> _getInternetTime() async {
    DateTime getNtpDateTime = await NTP.now().catchError(
      (error) {
        showSnackBar(
            context,
            Icons.signal_wifi_connected_no_internet_4,
            Colors.red,
            "No internet, please check your connection!",
            Colors.red);
        return DateTime.now();
      },
    );

    ref.read(adminProjectCreateInternetDateProvider.notifier).state =
        getNtpDateTime;
  }

  bool fieldValidation(
    DateTime? startDate,
    DateTime? endDate,
  ) {
    if (_nameCtl.text.isNotEmpty ||
        _descCtl.text.isNotEmpty ||
        startDate != null ||
        endDate != null) {
      return true;
    } else {
      return false;
    }
  }

  void submit(context) async {
    final startDate = ref.read(adminProjectCreateStartDateProvider);
    final endDate = ref.read(adminProjectCreateEndDateProvider);
    ref.read(adminProjectCreateIsLoadingProvider.notifier).state = true;
    if (!fieldValidation(startDate, endDate)) {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Fill the requirement ", Colors.red);
    } else {
      final isSuccess =
          await ref.read(adminProjectControllerProvider.notifier).createProject(
                name: _nameCtl.text.trim(),
                description: _descCtl.text.trim(),
                startDate: startDate!,
                endDate: endDate!,
              );
      if (isSuccess) {
        showSnackBar(context, Icons.done, Colors.greenAccent,
            "Success, Project Created", Colors.greenAccent);
        Navigator.pop(context);
        return;
      }
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Failed, please try again!", Colors.red);
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
    final internetDateTimeNow =
        ref.read(adminProjectCreateInternetDateProvider);
    final startDate = ref.watch(adminProjectCreateStartDateProvider);
    final endDate = ref.watch(adminProjectCreateEndDateProvider);
    final isLoading = ref.watch(adminProjectCreateIsLoadingProvider);
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputTextField(
              context,
              _keyTitle,
              'Project Name',
              _nameCtl,
              TextInputType.text,
              false,
              false,
              1,
            ),
            inputTextField(
              context,
              _keyDesc,
              "Project Description",
              _descCtl,
              TextInputType.text,
              false,
              false,
              4,
            ),
            ViewWithIcon(
              text: startDate != null
                  ? DateFormat.yMMMEd().format(startDate)
                  : "Select Start Date ->",
              iconLeading: null,
              iconTrailing: Icons.edit_calendar,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: startDate ?? internetDateTimeNow,
                  firstDate: internetDateTimeNow,
                  lastDate: internetDateTimeNow.add(const Duration(days: 1770)),
                );
                ref.read(adminProjectCreateStartDateProvider.notifier).state =
                    pickedDate;
              },
            ),
            ViewWithIcon(
              text: endDate != null
                  ? DateFormat.yMMMEd().format(endDate)
                  : "Select End Date ->",
              iconLeading: null,
              iconTrailing: Icons.edit_calendar,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: endDate ?? internetDateTimeNow,
                  firstDate: internetDateTimeNow,
                  lastDate: internetDateTimeNow.add(const Duration(days: 1770)),
                );
                ref.read(adminProjectCreateEndDateProvider.notifier).state =
                    pickedDate;
              },
            ),
            sizedSpacer(context: context, height: 30.0),
            customButton(
              context,
              isLoading,
              'CREATE',
              ConstColor(context)
                  .getConstColor(ConstColorEnum.kNormalButtonColor.name),
              () => submit(context),
            ),
            sizedSpacer(context: context, height: 30.0),
          ],
        ),
      ),
    );
  }
}
