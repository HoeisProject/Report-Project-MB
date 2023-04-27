import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

class ViewWithIcon extends StatelessWidget {
  // the values we need
  final String text;
  final IconData iconLeading;
  final IconData iconTrailing;
  final void Function() onPressed;

  const ViewWithIcon({
    super.key,
    required this.text,
    required this.iconLeading,
    required this.iconTrailing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(
          iconLeading,
          color: Colors.teal,
        ),
        title: Text(
          text,
          style: kHeaderTextStyle,
        ),
        trailing: GestureDetector(
          onTap: onPressed,
          child: Icon(
            iconTrailing,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
