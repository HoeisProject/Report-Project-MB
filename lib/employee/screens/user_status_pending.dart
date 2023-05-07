import 'package:flutter/material.dart';

class UserStatusPendingScreen extends StatelessWidget {
  const UserStatusPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Flexible(
          child: Text(
            "Your account still not verified,\nplease wait for admin verified your account!",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
