import 'package:flutter/material.dart';
import 'package:report_project/feature_1/auth/screens/user_profile.dart';

Widget showDrawer(BuildContext context) {
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width / 1.5,
    height: MediaQuery.of(context).size.height,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            drawerHeaderWidget(),
            drawerItemNavigate(context, Icons.person, "Profile", () {
              Navigator.pushNamed(context, UserProfilePage.routeName);
            }),
            drawerItemNavigate(context, Icons.logout, "Logout", () {}),
          ],
        ),
      ),
    ),
  );
}

Widget drawerHeaderWidget() {
  return const UserAccountsDrawerHeader(
    accountName: Text("Username"),
    accountEmail: Text("User Email"),
    currentAccountPicture: CircleAvatar(
      backgroundImage: NetworkImage(
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80"),
    ),
    decoration: BoxDecoration(
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
