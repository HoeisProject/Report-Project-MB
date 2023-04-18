import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget inputIconTextField(
  BuildContext context,
  GlobalKey<FormState> fieldKey,
  String hintText,
  IconData icon,
  TextEditingController controller,
  TextInputType inputType,
  bool obscureText,
) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.teal,
      ),
      title: Form(
        key: fieldKey,
        child: TextFormField(
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: hintText,
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Field Can\'t Be Empty';
            } else {
              return null;
            }
          },
          style: kInputTextStyle,
          obscureText: obscureText,
          controller: controller,
          keyboardType: inputType,
          maxLines: 1,
        ),
      ),
    ),
  );
}
