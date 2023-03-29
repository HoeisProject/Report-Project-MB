import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/auth/services/profile_service.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class UserProfilePage extends StatefulWidget {
  static const routeName = '/user_profile_screen';

  const UserProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  ParseUser? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileService().getCurrentUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? username = user?.get<String>('username');
    String? nik = user?.get<String>('nik');
    String? email = user?.get<String>('email');
    String? imagePath = user?.get<ParseFile>('userImage')?.url ?? '';
    return Scaffold(
      appBar: customAppbar("USER PROFILE"),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            profileHeader(Colors.black, username ?? "Username", imagePath),
            sizedSpacer(
              height: 20,
              width: 200,
            ),
            ViewIconField(
              text: nik ?? 'NIK User',
              icon: Icons.credit_card,
              onPressed: () {},
            ),
            ViewIconField(
              text: email ?? 'Email User',
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
