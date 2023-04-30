import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/view_model/account_verify_view_model.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';

class AccountVerify extends ConsumerStatefulWidget {
  const AccountVerify({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountVerifyState();
}

class _AccountVerifyState extends ConsumerState<AccountVerify> {
  final keyNik = GlobalKey<FormState>();
  final nikCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: accountVerification(context, ref),
    );
  }

  Widget accountVerification(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                sizedSpacer(height: 5.0),
                inputMediaField(context, "ktp Image",
                    ref.watch(accountVerifyMediaFileProvider), () {
                  getMediaFromCamera();
                }),
                sizedSpacer(height: 5.0),
                inputTextField(
                  context,
                  keyNik,
                  "Nik",
                  nikCtl,
                  TextInputType.number,
                  false,
                  true,
                  1,
                ),
                sizedSpacer(height: 5.0),
                customButton(
                  context,
                  ref.watch(accountVerifyLoadingProvider),
                  "SEND",
                  Colors.lightBlue,
                  () => sendVerifyRequest(context),
                ),
                sizedSpacer(height: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendVerifyRequest(context) async {
    final ktp = ref.read(accountVerifyMediaFileProvider);
    showLoadingDialog(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (ktp == null || nikCtl.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
      return;
    }
    final response =
        await ref.read(profileControllerProvider.notifier).verifyUser(
              nik: nikCtl.text.trim(),
              ktp: ktp,
            );
    if (response) {
      debugPrint('Verification request sent');
      Navigator.pop(context);
      showSnackBar(context, Icons.done, Colors.greenAccent,
          "Verification request sent", Colors.greenAccent);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Failed, please try again!", Colors.red);
    }
  }

  void getMediaFromCamera() async {
    try {
      List<Media>? getMedia = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 800,
        language: Language.English,
      );
      if (getMedia != null) {
        String? imagePath = getMedia[0].thumbPath;
        ref.read(accountVerifyMediaFileProvider.notifier).state =
            File(imagePath!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
