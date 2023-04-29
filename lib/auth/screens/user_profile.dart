import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:report_project/auth/widgets/account_verify.dart';
import 'package:report_project/auth/widgets/user_profile_edit_image.dart';
import 'package:report_project/auth/widgets/user_profile_edit_text.dart';
import 'package:report_project/common/controller/role_controller.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const routeName = '/user_profile_screen';

  final UserModel userModel;

  const UserProfileScreen({super.key, required this.userModel});

  @override
  ConsumerState<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  String username = "Username";
  String userImage =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330";
  String? ktpImage =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330";
  String phoneNumber = "User Phone Number";
  String? nik = "User Nik";
  String role = "employee";
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

    final currentRole = ref
        .read(roleControllerProvider.notifier)
        .findById(widget.userModel.roleId);
    role = currentRole.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("USER PROFILE"),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileHeader(Colors.black, username, userImage),
              sizedSpacer(
                height: 20,
                width: 200,
              ),
              ViewWithIcon(
                text: phoneNumber,
                iconLeading: Icons.phone,
                iconTrailing: Icons.edit,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext dialogContext) {
                      return UserProfileEditText(
                        label: "phone number",
                        oldValue: phoneNumber,
                        iconLeading: Icons.phone,
                        onPressed: () {},
                        inputType: TextInputType.phone,
                        obscureText: false,
                      );
                    },
                  );
                },
              ),
              ViewWithIcon(
                text: email,
                iconLeading: Icons.email,
                iconTrailing: Icons.edit,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext dialogContext) {
                      return UserProfileEditText(
                        label: "email",
                        oldValue: email,
                        iconLeading: Icons.email,
                        onPressed: () {},
                        inputType: TextInputType.emailAddress,
                        obscureText: false,
                      );
                    },
                  );
                },
              ),
              role == RoleModelNameEnum.employee.name
                  ? ktpField(context, nik, ktpImage, isUserVerified)
                  : Container()
            ],
          ),
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
        FloatingActionButton(
          tooltip: "Change Image",
          child: const Icon(
            Icons.edit,
            size: 15.0,
          ),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return UserProfileEditImage(
                  label: "profile image",
                  oldImage: imagePath,
                  onPressed: () {},
                );
              },
            );
          },
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
  context,
  String? nik,
  String? imagePath,
  bool isUserVerified,
) {
  if (!isUserVerified) {
    return SizedBox(
      width: 150.0,
      height: 100.0,
      child: ElevatedButton(
          // onPressed: () => accountVerify(context),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (dialogContext) {
                return const AccountVerify();
              },
            );
          },
          child: const Text(
            "Account Verification",
            style: kButtonTextStyle,
          )),
    );
  }

  return Column(
    children: [
      Center(
        child: SizedBox(
          width: 125.0,
          height: 150.0,
          child: imagePath != null
              ? Stack(
                  children: [
                    Positioned(
                      child: FloatingActionButton(
                        tooltip: "Change Image",
                        child: const Icon(
                          Icons.edit,
                          size: 15.0,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext dialogContext) {
                              return UserProfileEditImage(
                                label: "ktp image",
                                oldImage: imagePath,
                                onPressed: () {},
                              );
                            },
                          );
                        },
                      ),
                    ),
                    PhotoView(
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
                    ),
                  ],
                )
              : const InkWell(
                  onTap: null,
                  child: Icon(Icons.add_a_photo, size: 50.0),
                ),
        ),
      ),
      ViewWithIcon(
        text: nik ?? '-',
        iconLeading: Icons.credit_card,
        iconTrailing: Icons.edit,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return UserProfileEditText(
                label: "nik",
                oldValue: nik ?? '-',
                iconLeading: Icons.credit_card,
                onPressed: () {},
                inputType: TextInputType.number,
                obscureText: false,
              );
            },
          );
        },
      ),
    ],
  );
}

// Widget accountVerify(context) {
//   return Container(
//     margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//     child: Center(
//       child: SizedBox(
//         height: 50.0,
//         width: 150.0,
//         child: ElevatedButton(
//           onPressed: () {
//             debugPrint('Account Verify');
//             showDialog(
//               context: context,
//               barrierDismissible: true,
//               builder: (dialogContext) {
//                 return const AccountVerify();
//               },
//             );
//           },
//           child: const Center(
//             child: Text('Verify Account', style: kButtonTextStyle),
//           ),
//         ),
//       ),
//     ),
//   );
// }
