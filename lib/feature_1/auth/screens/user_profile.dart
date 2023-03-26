import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/view_text_field.dart';
import 'package:report_project/feature_1/employee/widgets/custom_appbar.dart';

class UserProfilePage extends StatefulWidget {
  static const routeName = '/user_profile_screen';

  const UserProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("USER PROFILE"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileHeader(Colors.white,
              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
          viewTextField(context, "Username", "Username field"),
          viewTextField(context, "Email", "Email field"),
          viewTextField(context, "NIK", "NIK field"),
        ],
      ),
    );
  }

  Widget profileHeader(Color color, String imagePath) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/rm309-aew-013_1_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=2724bd9481a065ee24e7e7eaaabf1c55",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: CircleAvatar(
          radius: 72,
          backgroundColor: color,
          child: CircleAvatar(
            backgroundImage: image as ImageProvider,
            radius: 70,
          ),
        ),
      ),
    );
  }
}
