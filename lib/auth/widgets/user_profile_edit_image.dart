import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/auth/view_model/user_profile_edit_view_model.dart';
import 'package:report_project/auth/widgets/view_image_field.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';

class UserProfileEditImage extends ConsumerWidget {
  final String label;
  final String oldImage;
  final void Function() onPressed;

  const UserProfileEditImage({
    super.key,
    required this.label,
    required this.oldImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.25,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color:
              ConstColor(context).getConstColor(ConstColorEnum.kBgColor.name),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                sizedSpacer(height: 5.0),
                viewImageField(context, "Old $label", oldImage),
                sizedSpacer(height: 15.0),
                inputMediaField(context, "new $label",
                    ref.watch(userProfileEditMediaFileProvider), () {
                  getMediaFromCamera(ref);
                }),
                sizedSpacer(height: 15.0),
                customButton(
                  context,
                  false,
                  "EDIT",
                  Colors.lightBlue,
                  () {},
                ),
                sizedSpacer(height: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldHeader(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: Text(
        text,
        style: kHeaderTextStyle,
      ),
    );
  }

  void getMediaFromCamera(WidgetRef ref) async {
    try {
      List<Media>? getMedia = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 800,
        language: Language.English,
      );
      if (getMedia != null) {
        String? imagePath = getMedia[0].thumbPath;
        ref.read(userProfileEditMediaFileProvider.notifier).state =
            File(imagePath!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
