import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_with_icon.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';

class UserProfileEditText extends StatelessWidget {
  final String label;
  final String oldValue;
  final IconData iconLeading;
  final void Function() onPressed;

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
  });

  @override
  Widget build(BuildContext context) {
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
            sizedSpacer(height: 5.0),
            fieldHeader("Old $label : "),
            ViewWithIcon(
              text: oldValue,
              iconLeading: iconLeading,
              iconTrailing: Icons.circle_outlined,
              onPressed: () {},
            ),
            sizedSpacer(height: 5.0),
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
            sizedSpacer(height: 5.0),
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
}
