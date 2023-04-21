import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:report_project/auth/widgets/account_verify.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user_profile_screen';

  final UserModel userModel;

  const UserProfileScreen({super.key, required this.userModel});

  @override
  State<StatefulWidget> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
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
          children: [
            profileHeader(Colors.black, username, userImage),
            sizedSpacer(
              height: 20,
              width: 200,
            ),
            ViewIconField(
              text: phoneNumber,
              icon: Icons.phone,
              onPressed: () {},
            ),
            ViewIconField(
              text: email,
              icon: Icons.email,
              onPressed: () {},
            ),
            ktpField(context, nik, ktpImage, isUserVerified)
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

Widget ktpField(
  BuildContext context,
  String? nik,
  String? imagePath,
  bool isUserVerified,
) {
  return !isUserVerified
      ? SizedBox(
          width: 150.0,
          height: 75.0,
          child: ElevatedButton(
              onPressed: () => accountVerify(context),
              child: const Text(
                "Account Verification",
                style: kButtonTextStyle,
              )),
        )
      : Column(
          children: [
            Center(
              child: SizedBox(
                width: 125.0,
                height: 150.0,
                child: imagePath != null
                    ? PhotoView(
                        loadingBuilder: (context, event) => Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              value: event == null
                                  ? 0
                                  : event.cumulativeBytesLoaded /
                                      (event.expectedTotalBytes ?? 1),
                            ),
                          ),
                        ),
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Text("$error"),
                          ),
                        ),
                        imageProvider: NetworkImage(imagePath),
                      )
                    : const InkWell(
                        onTap: null,
                        child: Icon(Icons.add_a_photo, size: 50.0),
                      ),
              ),
            ),
            ViewIconField(
              text: nik ?? '-',
              icon: Icons.credit_card,
              onPressed: () {},
            ),
          ],
        );
}

Widget accountVerify(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
    child: Center(
      child: SizedBox(
        height: 50.0,
        width: 150.0,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return const AccountVerify();
              },
            );
          },
          child: const Center(
            child: Text('Verify Account', style: kButtonTextStyle),
          ),
        ),
      ),
    ),
  );
}
