import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminDetailReportScreen extends StatefulWidget {
  static const routeName = '/admin_report_detail_screen';

  final ParseObject reportObject;

  const AdminDetailReportScreen({super.key, required this.reportObject});

  @override
  State<StatefulWidget> createState() => AdminDetailReportScreenState();
}

class AdminDetailReportScreenState extends State<AdminDetailReportScreen> {
  List<String?> listMediaFilePath = [];

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
                viewTextField(context, "Project Title", "Project Title"),
                viewTextField(context, "Report by", "Report by"),
                viewTextField(context, "Time and Date", "Time and Date"),
                viewTextField(context, "Location", "Location"),
                viewTextField(
                    context, "Project Description", "Project Description"),
                viewMediaField(context, "Attach Media", listMediaFilePath),
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

  void rejectReport() {
    // showLoadingDialog(context);
    // AdminService().updateReportStatus(reportObjectId, 2).then((value) {
    //   if (value.success) {
    //     Navigator.pop(context);
    //     showSnackBar(context, Icons.done, Colors.greenAccent,
    //         "Rejection Success", Colors.greenAccent);
    //     Navigator.pushNamedAndRemoveUntil(context, AdminHomeScreen.routeName,
    //         (Route<dynamic> route) => false);
    //   } else {
    //     Navigator.pop(context);
    //     showSnackBar(context, Icons.error_outline, Colors.red,
    //         "Rejection Failed", Colors.red);
    //   }
    // });
  }

  void approveReport() {
    //   showLoadingDialog(context);
    //   AdminService().updateReportStatus(reportObjectId, 1).then((value) {
    //     if (value.success) {
    //       Navigator.pop(context);
    //       showSnackBar(context, Icons.done, Colors.greenAccent,
    //           "Approval Success", Colors.greenAccent);
    //       Navigator.pushNamedAndRemoveUntil(context, AdminHomeScreen.routeName,
    //           (Route<dynamic> route) => false);
    //     } else {
    //       Navigator.pop(context);
    //       showSnackBar(context, Icons.error_outline, Colors.red,
    //           "Approval Failed", Colors.red);
    //     }
    //   });
  }
}
