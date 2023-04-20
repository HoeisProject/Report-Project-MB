import 'package:flutter/material.dart';

class NotVerifiedScreen extends StatelessWidget {
  const NotVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('You are not verified, Please contact admin')),
    );
  }
}
