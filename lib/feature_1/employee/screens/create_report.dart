import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_alert_dialog.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';
import 'package:report_project/feature_1/employee/widgets/report_attach_media.dart';

class ReportCreate extends StatefulWidget {
  static const routeName = '/report_create_screen';

  const ReportCreate({super.key});

  @override
  State<StatefulWidget> createState() => ReportCreateState();
}

class ReportCreateState extends State<ReportCreate> {
  var keyProjectTitle = GlobalKey<FormState>();
  var keyProjectDesc = GlobalKey<FormState>();

  TextEditingController projectTitleCtl = TextEditingController();
  TextEditingController projectDescCtl = TextEditingController();

  List<File?>? listMediaFile;

  bool? isLoading = false;

  DateTime? _projectCreated;

  Position? position;

  String? locationAddress = 'Loading...';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDateTimeLoc();
  }

  Future<void> _getDateTimeLoc() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return await showAlertDialog(
        context: context,
        icon: Icons.warning,
        title: "Location Unavailable",
        content: "Location services are disabled,\nplease enable it!",
        defaultActionText: "CLOSE",
        onButtonPressed: () {},
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await showAlertDialog(
          context: context,
          icon: Icons.warning,
          title: "Location Unavailable",
          content: "Location permissions are denied\nplease approve it",
          defaultActionText: "CLOSE",
          onButtonPressed: () {},
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return await showAlertDialog(
        context: context,
        icon: Icons.warning,
        title: "Location Unavailable",
        content:
            "Location permissions are denied permanently\nplease approve it",
        defaultActionText: "CLOSE",
        onButtonPressed: () {},
      );
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark place = placeMarks[0];

    setState(() async {
      _projectCreated = await NTP.now();

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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: ListView(
          children: [
            inputTextField(context, keyProjectTitle, "Project Title",
                projectTitleCtl, TextInputType.text, false, 1, (value) {}),
            viewTextField(context, "Time and Date",
                DateFormat.yMMMEd().format(_projectCreated!)),
            viewTextField(context, "Location", locationAddress!),
            inputTextField(context, keyProjectDesc, "Project Description",
                projectDescCtl, TextInputType.text, false, 6, (value) {}),
            reportAttachMedia(context, "Attach Media", listMediaFile, () {}),
            customButton(context, isLoading, "SEND", () {})
          ],
        ),
      ),
    );
  }
}
