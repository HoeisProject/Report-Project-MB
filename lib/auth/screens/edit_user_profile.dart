import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class EditUserProfileScreen extends StatefulWidget {
  static const routeName = '/edit_user_profile_screen';

  final UserModel userModel;

  const EditUserProfileScreen({super.key, required this.userModel});

  @override
  State<StatefulWidget> createState() => EditUserProfileScreenState();
}

class EditUserProfileScreenState extends State<EditUserProfileScreen> {
  String username = "Username";
  String userImage =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330";
  String? ktpImage =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330";
  String phoneNumber = "User Phone Number";
  String? nik = "User Nik";
  String email = "User Email";
  bool isUserVerified = false;

  @override
  void initState() {
    super.initState();
    username = widget.userModel.username;
    userImage = widget.userModel.userImage;
    ktpImage = widget.userModel.ktpImage;
    nik = widget.userModel.nik;
    phoneNumber = widget.userModel.phoneNumber;
    email = widget.userModel.email;
    isUserVerified = widget.userModel.isUserVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("USER PROFILE"),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: [],
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
