import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/view_model/login_register_view_model.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/styles/constant_style.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/common/widgets/input_media_field.dart';
import 'package:report_project/common/widgets/input_text_field.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/title_context.dart';
import 'package:report_project/admin/screens/admin_home.dart';
import 'package:report_project/auth/controllers/auth_controller.dart';
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

  final keyEmailField = GlobalKey<FormState>();
  final keyPasswordField = GlobalKey<FormState>();
  final keyPhoneNumberField = GlobalKey<FormState>();

  final usernameCtl = TextEditingController();

  final emailCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final phoneNumberCtl = TextEditingController();

  final ImagePicker picker = ImagePicker();

  void login(context) async {
    ref.read(loginRegisterLoadingProvider.notifier).state = true;
    if (!fieldValidation()) {
      ref.read(loginRegisterLoadingProvider.notifier).state = false;
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
      return;
    }
    final errorMessage = await ref.read(authControllerProvider).login(
          email: emailCtl.text.trim(),
          password: passwordCtl.text.trim(),
        );
    ref.read(loginRegisterLoadingProvider.notifier).state = false;
    if (errorMessage.isNotEmpty) {
      showSnackBar(
          context, Icons.error_outline, Colors.red, errorMessage, Colors.red);
      return;
    }
  }

  void register(context) async {
    ref.read(loginRegisterLoadingProvider.notifier).state = true;
    if (!fieldValidation()) {
      ref.read(loginRegisterLoadingProvider.notifier).state = false;
      showSnackBar(context, Icons.error_outline, Colors.red,
          "There is empty field!", Colors.red);
      return;
    }
    final errorMessage = await ref.read(authControllerProvider).register(
          username: usernameCtl.text.trim(),
          email: emailCtl.text.trim(),
          phoneNumber: phoneNumberCtl.text.trim(),
          password: passwordCtl.text.trim(),
          userImagePath: ref.read(loginRegisterMediaFileProvider)!.path,
        );
    if (errorMessage.isNotEmpty) {
      ref.read(loginRegisterLoadingProvider.notifier).state = false;
      showSnackBar(
          context, Icons.error_outline, Colors.red, errorMessage, Colors.red);
      return;
    } else {
      showSnackBar(context, Icons.done, Colors.greenAccent, "Register Success",
          Colors.greenAccent);
      ref.read(loginRegisterIsLoginProvider.notifier).state = true;
      ref.read(loginRegisterLoginColorProvider.notifier).state =
          ConstColor(context)
              .getConstColor(ConstColorEnum.kTextThemeColor.name);
      ref.read(loginRegisterRegisterColorProvider.notifier).state =
          Colors.lightBlue;
    }

    ref.read(loginRegisterLoadingProvider.notifier).state = false;
  }

  bool fieldValidation() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (ref.read(loginRegisterIsLoginProvider)) {
      if (emailCtl.text.trim().isNotEmpty &&
          passwordCtl.text.trim().isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      if (usernameCtl.text.trim().isNotEmpty &&
          emailCtl.text.trim().isNotEmpty &&
          passwordCtl.text.trim().isNotEmpty &&
          phoneNumberCtl.text.trim().isNotEmpty &&
          ref.read(loginRegisterMediaFileProvider) != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  void getMediaFromCamera() async {
    try {
      XFile? getMedia = await picker.pickImage(source: ImageSource.camera);
      if (getMedia != null) {
        String imagePath = getMedia.path;
        ref.read(loginRegisterMediaFileProvider.notifier).state =
            File(imagePath);
      }
    } catch (e) {
      debugPrint('getMediaFromCamera: ${e.toString()}');
    }
  }

  void changeToLoginCard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (ref.read(loginRegisterIsLoginProvider) == false) {
      ref.read(loginRegisterLoadingProvider.notifier).state = false;
      ref.read(loginRegisterLoginColorProvider.notifier).state =
          ConstColor(context)
              .getConstColor(ConstColorEnum.kTextThemeColor.name);
      ref.read(loginRegisterRegisterColorProvider.notifier).state =
          Colors.lightBlue;
      ref.read(loginRegisterIsLoginProvider.notifier).state = true;
      emailCtl.clear();
      passwordCtl.clear();
    }
  }

  void changeToRegisterCard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (ref.read(loginRegisterIsLoginProvider) == true) {
      ref.read(loginRegisterLoadingProvider.notifier).state = false;
      ref.read(loginRegisterLoginColorProvider.notifier).state =
          Colors.lightBlue;
      ref.read(loginRegisterRegisterColorProvider.notifier).state =
          ConstColor(context)
              .getConstColor(ConstColorEnum.kTextThemeColor.name);
      ref.read(loginRegisterIsLoginProvider.notifier).state = false;
      usernameCtl.clear();
      emailCtl.clear();
      passwordCtl.clear();
      phoneNumberCtl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(profileControllerProvider);

    ref.listen(profileControllerProvider, (previous, next) {
      debugPrint('ref listen - profileControllerProvider - login-register');
      debugPrint(next.value.toString());
      if (!next.hasValue || next.value == null) return;

      final currentRole = next.value!.role!;
      if (currentRole.name == RoleModelNameEnum.admin.name) {
        Navigator.popAndPushNamed(context, AdminHomeScreen.routeName);
      } else if (currentRole.name == RoleModelNameEnum.employee.name) {
        Navigator.popAndPushNamed(context, EmployeeHomeScreen.routeName);
      }
    });

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: currentUser.when(
          data: (user) {
            debugPrint('Current User: ${user.toString()}');
            if (user == null) return _body();
            return const Text('Debug Testing');
          },
          error: (error, stackTrace) {
            return const ErrorScreen(text: 'Login Register Call developer');
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 10.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: ref.watch(loginRegisterIsLoginProvider)
                ? _loginCard(context)
                : _registerCard(context),
          ),
        ),
      ),
    );
  }

  Widget _loginCard(context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            sizedSpacer(context: context, height: 10.0),
            titleContext("LOGIN"),
            sizedSpacer(context: context, height: 5.0),
            inputTextField(
              context,
              keyEmailField,
              "Email",
              emailCtl,
              TextInputType.text,
              false,
              false,
              1,
            ),
            sizedSpacer(context: context, height: 5.0),
            inputTextField(
              context,
              keyPasswordField,
              "Password",
              passwordCtl,
              TextInputType.text,
              true,
              false,
              1,
            ),
            sizedSpacer(context: context, height: 5.0),
            customButton(
              context,
              ref.watch(loginRegisterLoadingProvider),
              "LOGIN",
              ConstColor(context)
                  .getConstColor(ConstColorEnum.kNormalButtonColor.name),
              () => login(context),
            ),
            sizedSpacer(
                context: context, height: 10.0, width: 150.0, thickness: 1.0),
            _logRegSwitchLink(
              "Login",
              "Register",
              ref.watch(loginRegisterLoginColorProvider),
              ref.watch(loginRegisterRegisterColorProvider),
              changeToLoginCard,
              changeToRegisterCard,
            ),
            sizedSpacer(context: context, height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _registerCard(context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            sizedSpacer(context: context, height: 10.0),
            titleContext("REGISTER"),
            sizedSpacer(context: context, height: 5.0),
            inputMediaField(
              context,
              "Profile Image",
              ref.watch(loginRegisterMediaFileProvider),
              () {
                getMediaFromCamera();
              },
            ),
            sizedSpacer(context: context, height: 5.0),
            inputTextField(
              context,
              keyUsernameField,
              "Username",
              usernameCtl,
              TextInputType.text,
              false,
              false,
              1,
            ),
            sizedSpacer(context: context, height: 5.0),
            inputTextField(
              context,
              keyPhoneNumberField,
              "Phone Number",
              phoneNumberCtl,
              TextInputType.phone,
              false,
              false,
              1,
            ),
            sizedSpacer(context: context, height: 5.0),
            inputTextField(
              context,
              keyEmailField,
              "Email",
              emailCtl,
              TextInputType.emailAddress,
              false,
              false,
              1,
            ),
            sizedSpacer(context: context, height: 5.0),
            inputTextField(
              context,
              keyPasswordField,
              "Password",
              passwordCtl,
              TextInputType.text,
              true,
              false,
              1,
            ),
            sizedSpacer(context: context, height: 5.0),
            customButton(
              context,
              ref.watch(loginRegisterLoadingProvider),
              "REGISTER",
              ConstColor(context)
                  .getConstColor(ConstColorEnum.kNormalButtonColor.name),
              () => register(context),
            ),
            sizedSpacer(
                context: context, height: 10.0, width: 150.0, thickness: 1.0),
            _logRegSwitchLink(
              "Login",
              "Register",
              ref.watch(loginRegisterLoginColorProvider),
              ref.watch(loginRegisterRegisterColorProvider),
              changeToLoginCard,
              changeToRegisterCard,
            ),
            sizedSpacer(context: context, height: 20.0),
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
