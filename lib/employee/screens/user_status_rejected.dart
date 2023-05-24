import 'package:flutter/material.dart';

class UserStatusRejectedScreen extends StatelessWidget {
  const UserStatusRejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Your account got rejected,\nplease check and resend your ktp image and NIK\non user profile menu",
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
