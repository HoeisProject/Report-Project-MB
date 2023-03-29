import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:report_project/feature_1/auth/screens/user_profile.dart';
import 'package:report_project/feature_1/auth/services/auth_service.dart';

Widget showDrawer(BuildContext context, ParseUser? user) {
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width / 1.5,
    height: MediaQuery.of(context).size.height,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            drawerHeaderWidget(user),
            drawerItemNavigate(context, Icons.person, "Profile", () {
              Navigator.pushNamed(context, UserProfilePage.routeName);
            }),
            drawerItemNavigate(context, Icons.logout, "Logout", () {
              AuthService().logout();
            }),
          ],
        ),
      ),
    ),
  );
}

Widget drawerHeaderWidget(ParseUser? user) {
  String? username = user?.get<String>('username');
  String? email = user?.get<String>('email');
  String? imagePath = user?.get<ParseFile>('userImage')?.url ?? '';
  return UserAccountsDrawerHeader(
    accountName: Text(username ?? "Username"),
    accountEmail: Text(email ?? "User email"),
    currentAccountPicture: CircleAvatar(
      backgroundImage: NetworkImage(imagePath),
    ),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/rm309-aew-013_1_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=2724bd9481a065ee24e7e7eaaabf1c55",
        ),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget drawerItemNavigate(BuildContext context, IconData icon, String label,
    VoidCallback? onButtonPressed) {
  return ListTile(
    leading: Icon(icon),
    title: Text(label),
    onTap: onButtonPressed,
  );
}
