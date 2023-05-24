import 'package:flutter/material.dart';

class UserStatusNoUploadScreen extends StatelessWidget {
  const UserStatusNoUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Please send your ktp image and NIK on user profile menu\n&\nplease wait for admin to verify your account!",
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
