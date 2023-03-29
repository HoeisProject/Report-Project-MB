import 'package:flutter/material.dart';

Future<void> showSelectMediaDialog({
  required BuildContext context,
  required String title,
  required String defaultActionText,
  required void Function()? onPressedGallery,
  required void Function()? onPressedCamera,
  required VoidCallback? onButtonPressed,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.info_outline,
        size: 50.0,
      ),
      title: Text(title),
      content: SizedBox(
        height: 150.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _attachMediaButton(Icons.image, "Gallery", onPressedGallery),
            _attachMediaButton(Icons.camera_alt, "Camera", onPressedCamera)
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () => onButtonPressed!(),
          child: SizedBox(
            width: 75.0,
            height: 30.0,
            child: Center(
              child: Text(
                defaultActionText,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _attachMediaButton(
    IconData icon, String label, void Function()? onPressed) {
  return SizedBox(
    height: 75.0,
    width: 75.0,
    child: Card(
      elevation: 5.0,
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 30.0,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    ),
  );
}
