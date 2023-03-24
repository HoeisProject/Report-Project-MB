import 'package:flutter/material.dart';

Widget showDrawer(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
    color: Colors.white,
    width: MediaQuery.of(context).size.width / 1.5,
    height: MediaQuery.of(context).size.height,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            drawerItemNavigate(context, Icons.person, "Profile", () {}),
            drawerItemNavigate(context, Icons.logout, "Logout", () {}),
          ],
        ),
      ),
    ),
  );
}

Widget drawerItemNavigate(BuildContext context, IconData icon, String label,
    VoidCallback? onButtonPressed) {
  return ElevatedButton(
    onPressed: onButtonPressed,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(icon),
        ),
        Expanded(
          flex: 3,
          child: Text(label,
              style: const TextStyle(
                fontSize: 16.0,
              )),
        ),
      ],
    ),
  );
}
