import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class DetailReportScreen extends StatefulWidget {
  static const routeName = '/report_detail_screen';

  const DetailReportScreen({super.key});

  @override
  State<StatefulWidget> createState() => DetailReportScreenState();
}

class DetailReportScreenState extends State<DetailReportScreen> {
  List<String?> listMediaFilePath = [];

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
                viewTextField(context, "Time and Date", "projectDateTime"),
                viewTextField(context, "Location", "projectLocation"),
                viewTextField(context, "Project Description", "projectDesc"),
                viewMediaField(context, "Attach Media", listMediaFilePath)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
