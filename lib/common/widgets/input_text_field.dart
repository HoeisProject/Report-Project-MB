import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

Widget inputTextField(
    BuildContext context,
    GlobalKey<FormState> fieldKey,
    String fieldLabel,
    TextEditingController controller,
    TextInputType inputType,
    bool obscureText,
    int maxLine,
    void Function(String)? onChange) {
  return Form(
    key: fieldKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          child: Text(
            fieldLabel,
            style: kHeaderTextStyle,
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
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
          maxLines: maxLine,
          onChanged: onChange,
        ),
      ],
    ),
  );
}
