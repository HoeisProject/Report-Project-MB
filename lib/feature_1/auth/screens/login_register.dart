import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/title_context.dart';
import 'package:report_project/feature_1/employee/screens/employee_home.dart';

class LoginRegisterScreen extends StatefulWidget {
  static const routeName = '/login_register_screen';

  const LoginRegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginRegisterScreenState();
}

class LoginRegisterScreenState extends State<LoginRegisterScreen> {
  var keyUsernameField = GlobalKey<FormState>();
  var keyNikField = GlobalKey<FormState>();
  var keyEmailField = GlobalKey<FormState>();
  var keyPasswordField = GlobalKey<FormState>();

  TextEditingController usernameCtl = TextEditingController();
  TextEditingController nikCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();

  File? mediaFile;

  bool? isLoading = false;
  bool? isLoginScreen = true;

  Color? loginSwitchColor = Colors.black;
  Color? registerSwitchColor = Colors.tealAccent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Card(
        child: Column(
          children: [
            isLoginScreen! ? _loginCard(context) : _registerCard(context),
            _logRegSwitchLink(
              "login",
              "register",
              loginSwitchColor!,
              registerSwitchColor!,
              () {
                if (isLoginScreen == false) {
                  setState(() {
                    isLoginScreen = true;
                  });
                }
              },
              () {
                if (isLoginScreen == true) {
                  setState(() {
                    isLoginScreen = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _loginCard(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          titleContext("LOGIN"),
          inputTextField(context, keyUsernameField, "Username", usernameCtl,
              TextInputType.text, false, 1, (value) {}),
          inputTextField(context, keyPasswordField, "Password", passwordCtl,
              TextInputType.text, true, 1, (value) {}),
          customButton(
            context,
            isLoading,
            "LOGIN",
            () {
              Navigator.popAndPushNamed(context, HomeEmployee.routeName);
            },
          )
        ],
      ),
    );
  }

  Widget _registerCard(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          titleContext("Register"),
          inputMediaField(context, "Profile Image", mediaFile, () {}),
          inputTextField(context, keyUsernameField, "Username", usernameCtl,
              TextInputType.text, false, 1, (value) {}),
          inputTextField(context, keyNikField, "Nik", nikCtl,
              TextInputType.text, false, 1, (value) {}),
          inputTextField(context, keyEmailField, "Email", emailCtl,
              TextInputType.emailAddress, false, 1, (value) {}),
          inputTextField(context, keyPasswordField, "Password", passwordCtl,
              TextInputType.text, true, 1, (value) {}),
          customButton(
            context,
            isLoading,
            "REGISTER",
            () {
              Navigator.popAndPushNamed(context, HomeEmployee.routeName);
            },
          )
        ],
      ),
    );
  }

  Widget _logRegSwitchLink(
      String firstLabel,
      String secondLabel,
      Color firstColor,
      Color secondColor,
      void Function()? onPressed_1,
      void Function()? onPressed_2) {
    return Center(
      child: SizedBox(
        height: 50.0,
        child: Row(
          children: [
            GestureDetector(
              onTap: onPressed_1,
              child: Text(
                firstLabel,
                style: TextStyle(color: firstColor),
              ),
            ),
            const VerticalDivider(),
            GestureDetector(
              onTap: onPressed_2,
              child: Text(
                secondLabel,
                style: TextStyle(color: secondColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
