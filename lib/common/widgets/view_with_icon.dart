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
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        leading: Icon(
          iconLeading,
          color: Colors.teal,
        ),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            text,
            style: kHeaderTextStyle,
            maxLines: 1,
          ),
        ),
        trailing: iconTrailing == Icons.circle_outlined
            ? null
            : GestureDetector(
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
