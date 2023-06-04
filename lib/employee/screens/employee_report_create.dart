import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';

import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_alert_dialog.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/controllers/report_controller.dart';
import 'package:report_project/employee/screens/employee_home.dart';
import 'package:report_project/employee/view_model/create_report_view_model.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:report_project/employee/widgets/project_category_dropdown.dart';
import 'package:report_project/employee/widgets/report_attach_media.dart';
import 'package:report_project/employee/widgets/select_media_dialog.dart';

class EmployeeCreateReportScreen extends ConsumerStatefulWidget {
  static const routeName = '/employee-report-create';

  const EmployeeCreateReportScreen({super.key});

  @override
  ConsumerState<EmployeeCreateReportScreen> createState() =>
      _ReportCreateState();
}

class _ReportCreateState extends ConsumerState<EmployeeCreateReportScreen> {
  final _keyReportTitle = GlobalKey<FormState>();
  final _keyReportDesc = GlobalKey<FormState>();

  final _reportTitleCtl = TextEditingController();
  final _reportDescCtl = TextEditingController();

  Position? position;

  @override
  void initState() {
    super.initState();
    _getDateTimeLoc(context);
  }

  @override
  void dispose() {
    super.dispose();
    _reportTitleCtl.dispose();
    _reportDescCtl.dispose();
  }

  Future<void> _getDateTimeLoc(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return await showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "Location Unavailable",
        content: "Location services are disabled,\nplease enable it!",
        defaultActionText: "CLOSE",
        onButtonPressed: () {
          Navigator.pushNamedAndRemoveUntil(context,
              EmployeeHomeScreen.routeName, (Route<dynamic> route) => false);
        },
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await showAlertDialog(
          context: context,
          icon: Icons.error_outline,
          title: "Location Unavailable",
          content: "Location permissions are denied\nplease approve it",
          defaultActionText: "CLOSE",
          onButtonPressed: () {
            Navigator.pushNamedAndRemoveUntil(context,
                EmployeeHomeScreen.routeName, (Route<dynamic> route) => false);
          },
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return await showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "Location Unavailable",
        content:
            "Location permissions are denied permanently\nplease approve it",
        defaultActionText: "CLOSE",
        onButtonPressed: () {
          Navigator.pushNamedAndRemoveUntil(context,
              EmployeeHomeScreen.routeName, (Route<dynamic> route) => false);
        },
      );
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark place = placeMarks[0];

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
    ref.read(createReportProjectCreatedProvider.notifier).state =
        getNtpDateTime;
    ref.read(createReportPositionProvider.notifier).state =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
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
        appBar: customAppbar("Create Report"),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final reportCreated = ref.watch(createReportProjectCreatedProvider);
    final locationAddress = ref.watch(createReportPositionProvider);
    final listMediaPickerFile =
        ref.watch(createReportListMediaPickerFileProvider);

    /// Used for Dropdown Category
    final projects = ref.watch(adminProjectControllerProvider);

    final projectCategorySelected =
        ref.watch(createReportProjectCategorySelectedProvider);

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputTextField(
              context,
              _keyReportTitle,
              "Report Title",
              _reportTitleCtl,
              TextInputType.text,
              false,
              false,
              1,
            ),
            projects.when(
              data: (data) {
                final projectCategories = [
                  const DropdownMenuItem(
                      value: '', child: Text('Choose Category...')),
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
                    debugPrint(value);
                    ref
                        .read(createReportProjectCategorySelectedProvider
                            .notifier)
                        .state = value ?? '';
                  },
                  const Icon(Icons.keyboard_arrow_down),
                );
              },
              error: (error, stackTrace) {
                return const Text('Error Happen');
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
            viewTextField(
                context,
                "Report Created At",
                reportCreated != null
                    ? DateFormat.yMMMEd().format(reportCreated)
                    : "getting network time...",
                false),
            viewTextField(context, "Report Location", locationAddress, false),
            inputTextField(
              context,
              _keyReportDesc,
              "Report Description",
              _reportDescCtl,
              TextInputType.text,
              false,
              true,
              3,
            ),
            reportAttachMedia(context, "Attach Media", listMediaPickerFile,
                () async {
              await showSelectMediaDialog(
                  context: context,
                  title: "Choose Media",
                  defaultActionText: "CLOSE",
                  onPressedGallery: () {
                    getMediaFromGallery();
                    Navigator.pop(context);
                  },
                  onPressedCamera: () {
                    getMediaFromCamera();
                    Navigator.pop(context);
                  },
                  onButtonPressed: () {
                    Navigator.pop(context);
                  });
            }),
            sizedSpacer(context: context, height: 30.0),
            customButton(
              context,
              false,
              "SEND",
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

  void submit(context) async {
    final listMediaPickerFile =
        ref.read(createReportListMediaPickerFileProvider);
    final projectCategorySelected =
        ref.read(createReportProjectCategorySelectedProvider);
    showLoadingDialog(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (!fieldValidation(listMediaPickerFile, projectCategorySelected)) {
      Navigator.pop(context);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
      return;
    }
    final errMsg = await ref.read(reportControllerProvider.notifier).create(
          projectId: projectCategorySelected,
          title: _reportTitleCtl.text.trim(),
          position: position!,
          description: _reportDescCtl.text.trim(),
          listMediaFile: listMediaPickerFile,
        );
    if (errMsg.isEmpty) {
      debugPrint('Done Create Report');
      Navigator.pop(context);
      showSnackBar(context, Icons.done, Colors.greenAccent, "Report Created",
          Colors.greenAccent);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Failed, please try again!", Colors.red);
    }
  }

  bool fieldValidation(
    List<Media> listMediaPickerFile,
    String projectCategorySelected,
  ) {
    if (_reportTitleCtl.text.trim().isNotEmpty &&
        _reportDescCtl.text.trim().isNotEmpty &&
        projectCategorySelected.isNotEmpty &&
        ref.read(createReportProjectCreatedProvider) != null &&
        position != null &&
        listMediaPickerFile.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void getMediaFromGallery() async {
    final listMediaPickerFile =
        ref.read(createReportListMediaPickerFileProvider.notifier);
    try {
      List<Media>? getMedia = await ImagesPicker.pick(
        count: 5,
        pickType: PickType.image,
        language: Language.English,
      );
      if (listMediaPickerFile.state.isEmpty) {
        if (getMedia != null) {
          listMediaPickerFile.state = getMedia;
        } else {
          listMediaPickerFile.state = [];
        }
      } else {
        if (getMedia != null) {
          listMediaPickerFile.state = [
            ...listMediaPickerFile.state,
            ...getMedia
          ];
        } else {}
      }
    } catch (e) {
      showSnackBar(
          context, Icons.error_outline, Colors.red, "Error: $e", Colors.red);
    }
  }

  void getMediaFromCamera() async {
    final listMediaPickerFile =
        ref.read(createReportListMediaPickerFileProvider.notifier);
    try {
      List<Media>? getMedia = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 800,
        language: Language.English,
      );
      if (listMediaPickerFile.state.isEmpty) {
        if (getMedia != null) {
          listMediaPickerFile.state = getMedia;
        } else {
          listMediaPickerFile.state = [];
        }
      } else {
        if (getMedia != null) {
          listMediaPickerFile.state = [
            ...listMediaPickerFile.state,
            ...getMedia
          ];
        } else {}
      }
    } catch (e) {
      showSnackBar(
          context, Icons.error_outline, Colors.red, "Error: $e", Colors.red);
    }
  }
}
