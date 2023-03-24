import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';

class AdminDetailReport extends StatefulWidget {
  static const routeName = '/admin_report_detail_screen';

  const AdminDetailReport({super.key});

  @override
  State<StatefulWidget> createState() => AdminDetailReportState();
}

class AdminDetailReportState extends State<AdminDetailReport> {
  File? mediaFile;

  bool? isLoadingReject = false;
  bool? isLoadingApprove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: ListView(
          children: [
            viewTextField(context, "Project Title", ""),
            viewTextField(context, "Time and Date", ""),
            viewTextField(context, "Location", ""),
            viewTextField(context, "Project Description", ""),
            viewMediaField(context, "Attach Media", mediaFile),
            Row(
              children: [
                customButton(context, isLoadingReject, "REJECT", () {}),
                customButton(context, isLoadingApprove, "APPROVE", () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
