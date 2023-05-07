import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/controller/show_image_full_func_controller.dart';
import 'package:report_project/common/styles/constant.dart';

class ShowDownloadLoadingDialog extends ConsumerStatefulWidget {
  const ShowDownloadLoadingDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ShowDownloadLoadingDialogState();
}

class ShowDownloadLoadingDialogState
    extends ConsumerState<ShowDownloadLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        elevation: 0.0,
        backgroundColor:
            ConstColor(context).getConstColor(ConstColorEnum.kBgColor.name),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircularProgressIndicator(
                  value: ref.watch(imageDownloadProgressProvider),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(ref.watch(imageDownloadTextProvider))
            ],
          ),
        ),
      ),
    );
  }
}
