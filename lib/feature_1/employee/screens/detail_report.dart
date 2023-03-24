import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';

class ReportDetail extends StatefulWidget {
  static const routeName = '/report_detail_screen';

  const ReportDetail({super.key});

  @override
  State<StatefulWidget> createState() => ReportDetailState();
}

class ReportDetailState extends State<ReportDetail> {
  File? mediaFile;

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
            viewMediaField(context, "Attach Media", mediaFile)
          ],
        ),
      ),
    );
  }
}
