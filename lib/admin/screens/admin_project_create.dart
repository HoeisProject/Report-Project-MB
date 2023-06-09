import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/controllers/admin_project_priority_controller.dart';
import 'package:report_project/admin/view_model/admin_project_create_view_model.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/common/widgets/category_dropdown.dart';
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
    if (_nameCtl.text.isNotEmpty &&
        _descCtl.text.isNotEmpty &&
        startDate != null &&
        endDate != null &&
        ref.read(adminProjectCreateTimeSpanSelected).isNotEmpty &&
        ref.read(adminProjectCreateMoneyEstimateSelected).isNotEmpty &&
        ref.read(adminProjectCreateManpowerSelected).isNotEmpty &&
        ref.read(adminProjectCreateMaterialFeasibilitySelected).isNotEmpty) {
      return true;
    }
    return false;
  }

  void submit(context) async {
    final startDate = ref.read(adminProjectCreateStartDateProvider);
    final endDate = ref.read(adminProjectCreateEndDateProvider);
    ref.read(adminProjectCreateIsLoadingProvider.notifier).state = true;
    if (!fieldValidation(startDate, endDate)) {
      ref.read(adminProjectCreateIsLoadingProvider.notifier).state = false;
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Fill the requirement ", Colors.red);
      return;
    }
    final errMsg = await ref
        .read(adminProjectControllerProvider.notifier)
        .createProject(
          name: _nameCtl.text.trim(),
          description: _descCtl.text.trim(),
          startDate: startDate!,
          endDate: endDate!,
          timeSpanId: ref.read(adminProjectCreateTimeSpanSelected),
          moneyEstimateId: ref.read(adminProjectCreateMoneyEstimateSelected),
          manpowerId: ref.read(adminProjectCreateManpowerSelected),
          materialFeasibilityId:
              ref.read(adminProjectCreateMaterialFeasibilitySelected),
        );
    if (errMsg.isEmpty) {
      showSnackBar(context, Icons.done, Colors.greenAccent,
          "Success, Project Created", Colors.greenAccent);
      Navigator.pop(context);
      return;
    }
    showSnackBar(context, Icons.error_outline, Colors.red,
        "Failed, please try again!", Colors.red);

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
              3,
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
            _timeSpanDropdown(),
            _moneyEstimateDropdown(),
            _manpowerDropdown(),
            _materialFeasibilityDropdown(),
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

  Widget _timeSpanDropdown() {
    final timeSpanList = ref.watch(getTimeSpanProvider);
    final timeSpanSelected = ref.watch(adminProjectCreateTimeSpanSelected);
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
                  .read(adminProjectCreateTimeSpanSelected.notifier)
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
        ref.watch(adminProjectCreateMoneyEstimateSelected);
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
                  .read(adminProjectCreateMoneyEstimateSelected.notifier)
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
    final manpowerSelected = ref.watch(adminProjectCreateManpowerSelected);
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
                  .read(adminProjectCreateManpowerSelected.notifier)
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
        ref.watch(adminProjectCreateMaterialFeasibilitySelected);
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
                  .read(adminProjectCreateMaterialFeasibilitySelected.notifier)
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
}
