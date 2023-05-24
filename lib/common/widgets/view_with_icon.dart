import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';

class ViewWithIcon extends StatelessWidget {
  final String text;
  final IconData? iconLeading;
  final IconData? iconTrailing;
  final void Function() onPressed;

  const ViewWithIcon({
    super.key,
    required this.text,
    this.iconLeading,
    this.iconTrailing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        leading: iconLeading == null
            ? null
            : Icon(
                iconLeading,
                color: Colors.teal,
              ),
        title: Text(
          text,
          style: kHeaderTextStyle,
          maxLines: 1,
        ),
        trailing: iconTrailing == null
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
