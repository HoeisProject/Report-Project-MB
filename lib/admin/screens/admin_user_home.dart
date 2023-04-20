import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_user_controller.dart';
import 'package:report_project/common/widgets/error_screen.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminUserHomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/admin-employee-home';
  const AdminUserHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminUserHomeScreenState();
}

class _AdminUserHomeScreenState extends ConsumerState<AdminUserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("User Management"),
      body: _body(context),
    );
  }

  Widget _body(context) {
    final users = ref.watch(adminUserControllerProvider);

    return users.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index].nickname),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const ErrorScreen(text: 'Employe Home Screen - Call Developer');
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
