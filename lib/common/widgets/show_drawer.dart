import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/auth/controllers/auth_controller.dart';
import 'package:report_project/auth/screens/user_profile.dart';
import 'package:report_project/common/widgets/show_loading_dialog.dart';
import 'package:report_project/common/widgets/switch_app_theme.dart';

import '../models/user_model.dart';

Widget showDrawer(context, WidgetRef ref, UserModel user) {
  return Container(
    color: Theme.of(context).scaffoldBackgroundColor,
    width: MediaQuery.of(context).size.width / 1.5,
    height: MediaQuery.of(context).size.height,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            drawerHeaderWidget(user),
            drawerItemNavigate(context, Icons.person, "Profile", () {
              Navigator.pushNamed(context, UserProfileScreen.routeName);
            }),
            switchAppTheme(context, ref),
            drawerItemNavigate(context, Icons.logout, "Logout", () async {
              showLoadingDialog(context);
              ref.read(authControllerProvider).logout();
            }),
          ],
        ),
      ),
    ),
  );
}

Widget drawerHeaderWidget(UserModel user) {
  const String defaultDrawerHeader =
      "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/rm309-aew-013_1_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=2724bd9481a065ee24e7e7eaaabf1c55";
  const String defaultImageProfile =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330";
  return UserAccountsDrawerHeader(
    accountName: Text(user.username),
    accountEmail: Text(user.email),
    currentAccountPicture: CircleAvatar(
      backgroundImage: NetworkImage(
        user.userImage.isEmpty ? defaultImageProfile : user.userImage,
      ),
    ),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          defaultDrawerHeader,
        ),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget drawerItemNavigate(
  BuildContext context,
  IconData icon,
  String label,
  VoidCallback? onButtonPressed,
) {
  return ListTile(
    leading: Icon(icon),
    title: Text(label),
    onTap: onButtonPressed,
  );
}
