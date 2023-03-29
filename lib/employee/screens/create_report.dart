import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:images_picker/images_picker.dart';

import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_alert_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/auth/controllers/auth_controller.dart';
import 'package:report_project/employee/controllers/project_report_controller.dart';
import 'package:report_project/employee/screens/employee_home.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:report_project/employee/widgets/report_attach_media.dart';
import 'package:report_project/employee/widgets/select_media_dialog.dart';

class CreateReportScreen extends ConsumerStatefulWidget {
  static const routeName = '/report_create_screen';

  const CreateReportScreen({super.key});

  @override
  ConsumerState<CreateReportScreen> createState() => _ReportCreateState();
}

class _ReportCreateState extends ConsumerState<CreateReportScreen> {
  var keyProjectTitle = GlobalKey<FormState>();
  var keyProjectDesc = GlobalKey<FormState>();

  TextEditingController projectTitleCtl = TextEditingController();
  TextEditingController projectDescCtl = TextEditingController();

  List<File?> listMediaFile = [];

  bool? isLoading = false;

  DateTime? projectCreated;

  Position? position;

  String? locationAddress = 'Getting location...';

  // ImagePicker picker = ImagePicker();

  List<Media> listMediaPickerFile = [];

  @override
  void initState() {
    super.initState();
    _getDateTimeLoc(context);
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
          Navigator.pushNamedAndRemoveUntil(
              context, employeeHomeScreen.routeName, (Route<dynamic> route) => false);
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
            Navigator.pushNamedAndRemoveUntil(context, employeeHomeScreen.routeName,
                (Route<dynamic> route) => false);
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
          Navigator.pushNamedAndRemoveUntil(
              context, employeeHomeScreen.routeName, (Route<dynamic> route) => false);
        },
      );
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark place = placeMarks[0];

    DateTime getNtpDateTime = await NTP.now();

    setState(() {
      projectCreated = getNtpDateTime;

      locationAddress =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
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
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputTextField(
                context,
                keyProjectTitle,
                "Project Title",
                projectTitleCtl,
                TextInputType.text,
                false,
                false,
                1,
                (value) {}),
            viewTextField(
                context,
                "Time and Date",
                projectCreated != null
                    ? DateFormat.yMMMEd().format(projectCreated!)
                    : "getting network time..."),
            viewTextField(context, "Location", locationAddress!),
            inputTextField(context, keyProjectDesc, "Project Description",
                projectDescCtl, TextInputType.text, false, true, 6, (value) {}),
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
            sizedSpacer(height: 30.0),
            customButton(
                context, isLoading, "SEND", Colors.lightBlue, createDataReport),
            sizedSpacer(height: 30.0),
          ],
        ),
      ),
    );
  }

  void createDataReport() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (!fieldValidation()) {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
    }
    ref
        .read(projectReportControllerProvider.notifier)
        .createProject(
          projectTitle: projectTitleCtl.text.trim(),
          projectDateTime: projectCreated!,
          projectPosition: position!,
          projectDesc: projectDescCtl.text.trim(),
          listMediaFile: listMediaPickerFile,
        )
        .then((value) {
      debugPrint('Done Create Project');
      Navigator.pop(context);
    });
  }

  bool fieldValidation() {
    if (projectTitleCtl.text.trim().isNotEmpty &&
        projectDescCtl.text.trim().isNotEmpty &&
        projectCreated != null &&
        position != null &&
        listMediaPickerFile.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void getMediaFromGallery() async {
    try {
      if (listMediaPickerFile.isEmpty) {
        List<Media>? getMedia = await ImagesPicker.pick(
          count: 5,
          pickType: PickType.image,
          language: Language.English,
        );
        setState(() {
          if (getMedia != null) {
            listMediaPickerFile = getMedia;
          } else {
            listMediaPickerFile = [];
          }
        });
      } else {
        List<Media>? getMedia = await ImagesPicker.pick(
          count: 5,
          pickType: PickType.image,
          language: Language.English,
        );
        setState(() {
          if (getMedia != null) {
            listMediaPickerFile.addAll(getMedia);
          } else {}
        });
      }
    } catch (e) {
      showSnackBar(
          context, Icons.error_outline, Colors.red, "Error: $e", Colors.red);
    }
  }

  void getMediaFromCamera() async {
    try {
      if (listMediaPickerFile.isEmpty) {
        List<Media>? getMedia = await ImagesPicker.openCamera(
          pickType: PickType.image,
          quality: 0.8,
          maxSize: 800,
          language: Language.English,
        );
        setState(() {
          if (getMedia != null) {
            listMediaPickerFile = getMedia;
          } else {
            listMediaPickerFile = [];
          }
        });
      } else {
        List<Media>? getMedia = await ImagesPicker.openCamera(
          pickType: PickType.image,
          quality: 0.8,
          maxSize: 800,
          language: Language.English,
        );
        setState(() {
          if (getMedia != null) {
            listMediaPickerFile.addAll(getMedia);
          } else {}
        });
      }
    } catch (e) {
      showSnackBar(
          context, Icons.error_outline, Colors.red, "Error: $e", Colors.red);
    }
  }
}