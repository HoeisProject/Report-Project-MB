import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

class ViewIconField extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  final void Function() onPressed;

  const ViewIconField(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: kHeaderTextStyle,
          ),
        ),
      ),
    );
  }
}
