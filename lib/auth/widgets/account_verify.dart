import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/common/widgets/input_text_field.dart';

class AccountVerify extends ConsumerStatefulWidget {
  const AccountVerify({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountVerifyState();
}

class _AccountVerifyState extends ConsumerState<AccountVerify> {
  @override
  Widget build(BuildContext context) {
    return accountVerification(context, ref);
  }

  Widget accountVerification(BuildContext context, WidgetRef ref) {
    final keyNik = GlobalKey<FormState>();
    final nikCtl = TextEditingController();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            inputTextField(context, keyNik, "Nik :", nikCtl,
                TextInputType.number, false, true, 1, (value) {}),
          ],
        ),
      ),
    );
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
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
