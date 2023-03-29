import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';

class AdminDetailReport extends StatefulWidget {
  static const routeName = '/admin_report_detail_screen';

  const AdminDetailReport({super.key});

  @override
  State<StatefulWidget> createState() => AdminDetailReportState();
}

class AdminDetailReportState extends State<AdminDetailReport> {
  List<File?> listMediaFile = [];

  bool? isLoadingReject = false;
  bool? isLoadingApprove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Detail Report"),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                viewTextField(context, "Project Title", "projectTitle"),
                viewTextField(context, "Report by", "uploadBy"),
                viewTextField(context, "Time and Date", "projectDateTime"),
                viewTextField(context, "Location", "projectLocation"),
                viewTextField(context, "Project Description", "projectDesc"),
                viewMediaField(context, "Attach Media", listMediaFile),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton(context, isLoadingReject, "REJECT", Colors.red,
                        rejectReport),
                    customButton(context, isLoadingApprove, "APPROVE",
                        Colors.greenAccent, approveReport)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void rejectReport() {}

  void approveReport() {}
}
