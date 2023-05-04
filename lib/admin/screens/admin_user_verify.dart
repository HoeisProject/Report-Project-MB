import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_user_controller.dart';
import 'package:report_project/admin/view_model/admin_user_verify_view_model.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

@immutable
class AdminUserVerifyArguments {
  final String id;
  final bool isUserVerified;
  final String? nik;
  final String? ktpImage;

  const AdminUserVerifyArguments({
    required this.id,
    required this.isUserVerified,
    required this.nik,
    required this.ktpImage,
  });
}

class AdminUserVerifyScreen extends ConsumerWidget {
  static const routeName = '/admin-user-verify';
  const AdminUserVerifyScreen({
    super.key,
    required this.id,
    required this.isUserVerified,
    required this.nik,
    required this.ktpImage,
  });
  final String id;
  final bool isUserVerified;
  final String? nik;
  final String? ktpImage;

  void submit(context, bool isApprove, WidgetRef ref) async {
    ref.read(adminUserVerifyIsLoadingProvider.notifier).state = true;
    final isSuccess = await ref
        .read(adminUserControllerProvider.notifier)
        .verifyUser(id: id, value: isApprove);

    if (isSuccess) {
      showSnackBar(context, Icons.done, Colors.greenAccent,
          "Success, Project Created", Colors.greenAccent);
      Navigator.pop(context);
      return;
    }
    ref.read(adminUserVerifyIsLoadingProvider.notifier).state = false;
    showSnackBar(context, Icons.error_outline, Colors.red,
        "Failed, please try again!", Colors.red);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar('Detail User'),
      body: _body(context, ref),
    );
  }

  Widget _body(context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Image.network(
              /// TODO UI nya menggigil wink
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.red);
              },
              ktpImage ?? '',
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(nik ?? ''),

          /// TODO Jika dia sudah di approve, maka tetap tampilin button ?
          customButton(
            context,
            ref.watch(adminUserVerifyIsLoadingProvider),
            isUserVerified ? 'REJECT' : 'APPROVE',
            isUserVerified ? Colors.red : Colors.greenAccent,
            () {
              isUserVerified
                  ? submit(context, false, ref)
                  : submit(context, true, ref);
              // submit(context, !isUserVerified, ref);  // Not semantics approuch
            },
          ),
        ],
      ),
    );
  }
}
