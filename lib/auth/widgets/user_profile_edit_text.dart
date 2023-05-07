import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_with_icon.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';

class UserProfileEditText extends ConsumerWidget {
  final String label;
  final String oldValue;
  final IconData iconLeading;
  final void Function() onPressed;
  final UserModelEnum userModelEnum;

  final keyNewValue = GlobalKey<FormState>();
  final newValueCtl = TextEditingController();
  final TextInputType inputType;
  final bool obscureText;

  UserProfileEditText({
    super.key,
    required this.label,
    required this.oldValue,
    required this.iconLeading,
    required this.onPressed,
    required this.inputType,
    required this.obscureText,
    required this.userModelEnum,
  });

  void update(context, WidgetRef ref) async {
    showLoadingDialog(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (newValueCtl.text.isEmpty) {
      Navigator.pop(context);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
      return;
    }
    final response =
        await ref.read(profileControllerProvider.notifier).updateByProperties(
              userModelEnum: userModelEnum,
              newValue: newValueCtl.text.trim(),
            );
    if (response) {
      debugPrint('Update ${userModelEnum.name} Field Complete');
      Navigator.pop(context);
      showSnackBar(context, Icons.done, Colors.greenAccent,
          'Update ${userModelEnum.name} Field Complete', Colors.greenAccent);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showSnackBar(context, Icons.error_outline, Colors.red,
          "Failed update ${userModelEnum.name}", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                sizedSpacer(context: context, height: 5.0),
                fieldHeader("Old $label : "),
                ViewWithIcon(
                  text: oldValue,
                  iconLeading: iconLeading,
                  iconTrailing: null,
                  onPressed: () {},
                ),
                sizedSpacer(context: context, height: 15.0),
                fieldHeader("New $label : "),
                inputWithIcon(
                  context,
                  keyNewValue,
                  "input new $label",
                  iconLeading,
                  newValueCtl,
                  inputType,
                  obscureText,
                ),
                sizedSpacer(context: context, height: 15.0),
                customButton(
                  context,
                  false,
                  "EDIT",
                  ConstColor(context)
                      .getConstColor(ConstColorEnum.kNormalButtonColor.name),
                  () => update(context, ref),
                ),
                sizedSpacer(context: context, height: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldHeader(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        style: kHeaderTextStyle,
      ),
    );
  }
}
