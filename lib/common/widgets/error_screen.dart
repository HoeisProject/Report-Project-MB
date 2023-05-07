import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.text});
  final String text;

  /// TODO Sesuai nama file nya, wajibnya ini buat Scaffold baru ??
  /// Call aaaee dah
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
