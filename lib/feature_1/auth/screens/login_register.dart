import 'dart:io';

import 'package:flutter/material.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/title_context.dart';
import 'package:report_project/feature_1/admin/screens/admin_home.dart';
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
  Color? registerSwitchColor = Colors.lightBlue;

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
      child: SizedBox(
        height: isLoginScreen!
            ? MediaQuery.of(context).size.height / 1.5
            : MediaQuery.of(context).size.height,
        width: isLoginScreen!
            ? MediaQuery.of(context).size.width / 1.2
            : MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                isLoginScreen! ? _loginCard(context) : _registerCard(context),
          ),
        ),
      ),
    );
  }

  Widget _loginCard(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
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
            ),
            _logRegSwitchLink(
              "Login",
              "Register",
              loginSwitchColor!,
              registerSwitchColor!,
              () {
                if (isLoginScreen == false) {
                  setState(() {
                    loginSwitchColor = Colors.black;
                    registerSwitchColor = Colors.lightBlue;
                    isLoginScreen = true;
                  });
                }
              },
              () {
                if (isLoginScreen == true) {
                  setState(() {
                    loginSwitchColor = Colors.lightBlue;
                    registerSwitchColor = Colors.black;
                    isLoginScreen = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerCard(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleContext("REGISTER"),
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
                Navigator.popAndPushNamed(context, AdminHome.routeName);
              },
            ),
            _logRegSwitchLink(
              "Login",
              "Register",
              loginSwitchColor!,
              registerSwitchColor!,
              () {
                if (isLoginScreen == false) {
                  setState(() {
                    loginSwitchColor = Colors.black;
                    registerSwitchColor = Colors.lightBlue;
                    isLoginScreen = true;
                  });
                }
              },
              () {
                if (isLoginScreen == true) {
                  setState(() {
                    loginSwitchColor = Colors.lightBlue;
                    registerSwitchColor = Colors.black;
                    isLoginScreen = false;
                  });
                }
              },
            ),
          ],
        ),
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
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Center(
        child: SizedBox(
          height: 25.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onPressed_1,
                child: Text(
                  firstLabel,
                  style: TextStyle(color: firstColor),
                ),
              ),
              const VerticalDivider(
                thickness: 2.5,
              ),
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
      ),
    );
  }
}
