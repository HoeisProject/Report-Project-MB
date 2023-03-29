import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/feature_1/admin/screens/admin_home.dart';
import 'package:report_project/feature_1/admin/services/admin_service.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';

class AdminDetailReport extends StatefulWidget {
  static const routeName = '/admin_report_detail_screen';

  final ParseObject reportObject;

  const AdminDetailReport({super.key, required this.reportObject});

  @override
  State<StatefulWidget> createState() => AdminDetailReportState();
}

class AdminDetailReportState extends State<AdminDetailReport> {
  List<String?> listMediaFilePath = [];

  bool? isLoadingReject = false;
  bool? isLoadingApprove = false;

  String reportObjectId = "";
  String projectTitle = "Loading...";
  String uploadBy = "Loading...";
  String projectDateTime = "Loading...";
  String projectLocation = "Loading...";
  String projectDesc = "Loading...";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    ParseObject reportObject = widget.reportObject;
    String? objectId = reportObject.get<String>('objectId')!;
    String? projectTitleObject = reportObject.get<String>('projectTitle');
    ParseUser? uploadByObject = reportObject.get<ParseUser>('uploadBy');
    DateTime? projectDateTimeObject =
        reportObject.get<DateTime>('projectDateTime');
    ParseGeoPoint? projectGeoPointObject =
        reportObject.get<ParseGeoPoint>('projectPosition');
    String? projectDescObject = reportObject.get<String>('projectDesc');

    List<Placemark> placeMarks = await placemarkFromCoordinates(
        projectGeoPointObject!.latitude, projectGeoPointObject.longitude);

    Placemark place = placeMarks[0];

    List<String?> tempMediaFile = [];

    List<ParseObject> reportMediaObject =
        await AdminService().getReportsMedia(objectId);

    for (var element in reportMediaObject) {
      ParseFile? getReportFile = element.get<ParseFile>('reportAttachment');
      tempMediaFile.add(getReportFile?.url);
    }

    setState(() {
      reportObjectId = objectId;
      listMediaFilePath = tempMediaFile;
      projectTitle = projectTitleObject!;
      uploadBy = uploadByObject?.username ?? "-";
      projectDateTime =
          DateFormat.yMMMEd().format(projectDateTimeObject ?? DateTime.now());
      projectLocation =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      projectDesc = projectDescObject!;
    });
  }

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
                viewTextField(context, "Project Title", projectTitle),
                viewTextField(context, "Report by", uploadBy),
                viewTextField(context, "Time and Date", projectDateTime),
                viewTextField(context, "Location", projectLocation),
                viewTextField(context, "Project Description", projectDesc),
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
    showLoadingDialog(context);
    AdminService().updateReportStatus(reportObjectId, 2).then((value) {
      if (value.success) {
        Navigator.pop(context);
        showSnackBar(context, Icons.done, Colors.greenAccent,
            "Rejection Success", Colors.greenAccent);
        Navigator.pushNamedAndRemoveUntil(
            context, AdminHome.routeName, (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        showSnackBar(context, Icons.error_outline, Colors.red,
            "Rejection Failed", Colors.red);
      }
    });
  }

  void approveReport() {
    showLoadingDialog(context);
    AdminService().updateReportStatus(reportObjectId, 1).then((value) {
      if (value.success) {
        Navigator.pop(context);
        showSnackBar(context, Icons.done, Colors.greenAccent,
            "Approval Success", Colors.greenAccent);
        Navigator.pushNamedAndRemoveUntil(
            context, AdminHome.routeName, (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        showSnackBar(context, Icons.error_outline, Colors.red,
            "Approval Failed", Colors.red);
      }
    });
  }
}
