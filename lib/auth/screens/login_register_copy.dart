import 'dart:io';

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/title_context.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/employee/screens/employee_home.dart';

class LoginRegisterScreen extends StatefulWidget {
  static const routeName = '/login_register_screen';

  const LoginRegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginRegisterScreenState();
}

class LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final keyUsernameField = GlobalKey<FormState>();
  final keyNikField = GlobalKey<FormState>();
  final keyEmailField = GlobalKey<FormState>();
  final keyPasswordField = GlobalKey<FormState>();

  final usernameCtl = TextEditingController();
  final nikCtl = TextEditingController();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();

  File? mediaFile;

  bool isLoading = false;
  bool isLoginScreen = true;

  Color loginSwitchColor = Colors.black;
  Color registerSwitchColor = Colors.lightBlue;

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
        height: MediaQuery.of(context).size.height / 1.25,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Card(
          elevation: 10.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: isLoginScreen ? _loginCard(context) : _registerCard(context),
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
            sizedSpacer(height: 10.0),
            titleContext("LOGIN"),
            sizedSpacer(height: 5.0),
            inputTextField(context, keyUsernameField, "Username", usernameCtl,
                TextInputType.text, false, false, 1, (value) {}),
            sizedSpacer(height: 5.0),
            inputTextField(context, keyPasswordField, "Password", passwordCtl,
                TextInputType.text, true, false, 1, (value) {}),
            sizedSpacer(height: 5.0),
            customButton(
              context,
              isLoading,
              "LOGIN",
              Colors.lightBlue,
              userLogin,
            ),
            sizedSpacer(height: 10.0, width: 150.0, thickness: 1.0),
            _logRegSwitchLink(
              "Login",
              "Register",
              loginSwitchColor,
              registerSwitchColor,
              changeToLoginCard,
              changeToRegisterCard,
            ),
            sizedSpacer(height: 20.0),
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
            sizedSpacer(height: 10.0),
            titleContext("REGISTER"),
            sizedSpacer(height: 5.0),
            inputMediaField(context, "Profile Image", mediaFile, () {
              getMediaFromCamera();
            }),
            sizedSpacer(height: 5.0),
            inputTextField(context, keyUsernameField, "Username", usernameCtl,
                TextInputType.text, false, false, 1, (value) {}),
            sizedSpacer(height: 5.0),
            inputTextField(context, keyNikField, "Nik", nikCtl,
                TextInputType.text, false, false, 1, (value) {}),
            sizedSpacer(height: 5.0),
            inputTextField(context, keyEmailField, "Email", emailCtl,
                TextInputType.emailAddress, false, false, 1, (value) {}),
            sizedSpacer(height: 5.0),
            inputTextField(context, keyPasswordField, "Password", passwordCtl,
                TextInputType.text, true, false, 1, (value) {}),
            sizedSpacer(height: 5.0),
            customButton(
              context,
              isLoading,
              "REGISTER",
              Colors.lightBlue,
              userRegister,
            ),
            sizedSpacer(height: 10.0, width: 150.0, thickness: 1.0),
            _logRegSwitchLink(
              "Login",
              "Register",
              loginSwitchColor,
              registerSwitchColor,
              changeToLoginCard,
              changeToRegisterCard,
            ),
            sizedSpacer(height: 20.0),
          ],
        ),
      ),
    );
  }

  void userLogin() {
    if (fieldValidation()) {
      Navigator.popAndPushNamed(context, HomeEmployee.routeName);
    } else {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
    }
  }

  void userRegister() {
    if (fieldValidation()) {
      Navigator.popAndPushNamed(context, AdminHome.routeName);
    } else {
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
    }
  }

  bool fieldValidation() {
    if (isLoginScreen) {
      if (usernameCtl.text.trim().isNotEmpty &&
          passwordCtl.text.trim().isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      if (usernameCtl.text.trim().isNotEmpty &&
          nikCtl.text.trim().isNotEmpty &&
          emailCtl.text.trim().isNotEmpty &&
          passwordCtl.text.trim().isNotEmpty &&
          mediaFile != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  void getMediaFromCamera() async {
    try {
      List<Media>? getMedia = await ImagesPicker.openCamera(
        pickType: PickType.image,
        quality: 0.8,
        maxSize: 800,
        language: Language.English,
      );
      if (getMedia != null) {
        String? imagePath = getMedia[0].thumbPath;
        setState(() {
          mediaFile = File(imagePath!);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _logRegSwitchLink(
    String firstLabel,
    String secondLabel,
    Color firstColor,
    Color secondColor,
    void Function()? onPressed_1,
    void Function()? onPressed_2,
  ) {
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

  void changeToLoginCard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (isLoginScreen == false) {
      setState(() {
        usernameCtl.clear();
        passwordCtl.clear();
        loginSwitchColor = Colors.black;
        registerSwitchColor = Colors.lightBlue;
        isLoginScreen = true;
      });
    }
  }

  void changeToRegisterCard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (isLoginScreen == true) {
      setState(() {
        usernameCtl.clear();
        nikCtl.clear();
        emailCtl.clear();
        passwordCtl.clear();
        loginSwitchColor = Colors.lightBlue;
        registerSwitchColor = Colors.black;
        isLoginScreen = false;
      });
    }
  }
}
