import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
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
            viewTextField(context, "Time and Date", ""),
            viewTextField(context, "Location", ""),
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
