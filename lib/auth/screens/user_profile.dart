import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user_profile_screen';

  const UserProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("USER PROFILE"),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            profileHeader(Colors.black, "Username",
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330"),
            sizedSpacer(
              height: 20,
              width: 200,
            ),
            ViewIconField(
              text: 'NIK User',
              icon: Icons.credit_card,
              onPressed: () {},
            ),
            ViewIconField(
              text: 'Email User',
              icon: Icons.email,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget profileHeader(Color color, String username, String imagePath) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return Column(
      children: [
        CircleAvatar(
          radius: 72,
          backgroundColor: color,
          child: CircleAvatar(
            backgroundImage: image as ImageProvider,
            radius: 70,
          ),
        ),
        Text(
          username,
          style: kTitleContextStyle,
        ),
      ],
    );
  }
}
