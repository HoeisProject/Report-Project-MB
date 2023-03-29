import 'dart:io';

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/title_context.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/auth/controllers/auth_controller.dart';
import 'package:report_project/auth/widgets/role_switch.dart';
import 'package:report_project/employee/screens/employee_home.dart';

class LoginRegisterScreen extends ConsumerStatefulWidget {
  static const routeName = '/login_register_screen';

  const LoginRegisterScreen({super.key});

  @override
  ConsumerState<LoginRegisterScreen> createState() =>
      _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends ConsumerState<LoginRegisterScreen> {
  final keyUsernameField = GlobalKey<FormState>();
  final keyNikField = GlobalKey<FormState>();
  final keyEmailField = GlobalKey<FormState>();
  final keyPasswordField = GlobalKey<FormState>();

  final usernameCtl = TextEditingController();
  final nikCtl = TextEditingController();
  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();

  bool isAdmin = false;
  String role = "employee";

  File? mediaFile;

  bool isLoading = false;
  bool isLoginScreen = true;

  Color loginSwitchColor = Colors.black;
  Color registerSwitchColor = Colors.lightBlue;

  void userLogin(context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      isLoading = true;
    });
    if (!fieldValidation()) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
      return;
    }
    final user = await ref.read(authControllerProvider.notifier).loginUser(
          username: usernameCtl.text.trim(),
          password: passwordCtl.text.trim(),
        );
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
          context, Icons.error_outline, Colors.red, "Login Failed", Colors.red);
      return;
    }

    if (user.role == "admin") {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, Icons.done, Colors.greenAccent, "Login Success",
          Colors.greenAccent);
      Navigator.popAndPushNamed(context, AdminHomeScreen.routeName);
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, Icons.done, Colors.greenAccent, "Login Success",
          Colors.greenAccent);
      Navigator.popAndPushNamed(context, employeeHomeScreen.routeName);
    }
  }

  void userRegister(context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      isLoading = true;
    });
    if (!fieldValidation()) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
    }
    final isSuccess =
        await ref.read(authControllerProvider.notifier).registerUser(
              imagePath: mediaFile!.path,
              username: usernameCtl.text.trim(),
              password: passwordCtl.text.trim(),
              email: emailCtl.text.trim(),
              nik: nikCtl.text.trim(),
              role: role,
            );
    if (!isSuccess) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, Icons.error_outline, Colors.red, "Register Failed",
          Colors.red);
    }
    showSnackBar(context, Icons.done, Colors.greenAccent, "Register Success",
        Colors.greenAccent);
    setState(() {
      isLoading = false;
    });
    setState(() {
      isLoginScreen = true;
      loginSwitchColor = Colors.black;
      registerSwitchColor = Colors.lightBlue;
    });
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
              () => userLogin(context),
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
            roleSwitch(context, "Set as admin", isAdmin, (value) {
              setState(() {
                isAdmin = value;
                if (isAdmin) {
                  role = "admin";
                } else {
                  role = "employee";
                }
              });
            }),
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
              () => userRegister(context),
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
}
