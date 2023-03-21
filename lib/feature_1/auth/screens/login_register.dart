import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  static const routeName = '/login_register_screen';

  const LoginRegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginRegisterScreenState();
}

class LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
}
