import 'package:flutter/material.dart';
import 'package:report_project/common/models/project_report_model.dart';
import 'package:report_project/common/widgets/view_media_field.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/employee/controllers/report_media_controller.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailReportScreen extends ConsumerWidget {
  static const routeName = '/report_detail_screen';

  final ProjectReportModel projectReport;

  const DetailReportScreen({
    super.key,
    required this.projectReport,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar("Detail Report"),
      body: _body(context, ref),
    );
  }

  Widget _body(context, WidgetRef ref) {
    final reportsMedia = ref.watch(getReportMediaProvider(
      reportId: projectReport.objectId,
    ));
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
                viewTextField(
                    context, "Project Title", projectReport.projectTitle),
                viewTextField(context, "Time and Date",
                    projectReport.projectDateTime.toString()),
                viewTextField(context, "Location",
                    projectReport.projectPosition.toString()),
                viewTextField(
                    context, "Project Description", projectReport.projectDesc),
                reportsMedia.when(
                  data: (data) {
                    final listMediaFilePath =
                        data.map((e) => e.reportAttachment).toList();
                    return viewMediaField(
                      context,
                      "Attach Media",
                      listMediaFilePath,
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        '${error.toString()} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                // viewMediaField(context, "Attach Media", listMediaFilePath),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class DetailReportScreen extends StatefulWidget {
//   static const routeName = '/report_detail_screen';

//   final ProjectReportModel projectReport;

//   const DetailReportScreen({
//     super.key,
//     required this.projectReport,
//   });

//   @override
//   State<StatefulWidget> createState() => DetailReportScreenState();
// }

// class DetailReportScreenState extends State<DetailReportScreen> {
//   List<String?> listMediaFilePath = [];

//   late final ProjectReportModel projectReport;

//   @override
//   void initState() {
//     super.initState();
//     debugPrint(widget.projectReport.toString());
//     projectReport = widget.projectReport;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppbar("Detail Report"),
//       body: _body(),
//     );
//   }

//   Widget _body() {
//     return Container(
//       margin: const EdgeInsets.all(10.0),
//       child: Card(
//         elevation: 5.0,
//         clipBehavior: Clip.hardEdge,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 viewTextField(
//                     context, "Project Title", projectReport.projectTitle),
//                 viewTextField(context, "Time and Date",
//                     projectReport.projectDateTime.toString()),
//                 viewTextField(context, "Location",
//                     projectReport.projectPosition.toString()),
//                 viewTextField(
//                     context, "Project Description", projectReport.projectDesc),
//                 viewMediaField(context, "Attach Media", listMediaFilePath),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
