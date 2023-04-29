import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/auth/view_model/account_verify_view_model.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
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
    return accountVerification(context, ref);
  }

  Widget accountVerification(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.25,
        width: MediaQuery.of(context).size.width / 1.2,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                () => sendVerifyRequest(),
              ),
              sizedSpacer(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }

  void sendVerifyRequest() {}

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
