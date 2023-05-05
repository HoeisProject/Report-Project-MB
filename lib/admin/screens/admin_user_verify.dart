import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_user_controller.dart';
import 'package:report_project/admin/view_model/admin_user_verify_view_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/show_image_full_func.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminUserVerifyScreen extends ConsumerWidget {
  static const routeName = '/admin-user-verify';

  const AdminUserVerifyScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  void submit(context, bool isApprove, WidgetRef ref) async {
    ref.read(adminUserVerifyIsLoadingProvider.notifier).state = true;
    final isSuccess = await ref
        .read(adminUserControllerProvider.notifier)
        .verifyUser(id: user.id, value: isApprove);

    if (isSuccess) {
      showSnackBar(context, Icons.done, Colors.greenAccent,
          "Success, user approved", Colors.greenAccent);
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
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userImageHeader(context, user.userImage),
                ViewWithIcon(
                  text: user.nickname,
                  iconLeading: Icons.person,
                  iconTrailing: null,
                  onPressed: () {},
                ),
                ViewWithIcon(
                  text: user.nik ?? '-',
                  iconLeading: Icons.credit_card,
                  iconTrailing: null,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 200.0,
                  child: Image.network(
                    user.ktpImage ?? '-',
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
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                customButton(
                  context,
                  ref.watch(adminUserVerifyIsLoadingProvider),
                  user.isUserVerified ? 'REJECT' : 'APPROVE',
                  user.isUserVerified ? Colors.red : Colors.greenAccent,
                  () {
                    user.isUserVerified
                        ? submit(context, false, ref)
                        : submit(context, true, ref);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userImageHeader(BuildContext context, String userImagePath) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 72,
            backgroundColor: ConstColor(context)
                .getConstColor(ConstColorEnum.kOutlineBorderColor.name),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowImageFullFunc(
                      listMediaFilePath: [userImagePath],
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: userImagePath,
                child: CircleAvatar(
                  backgroundColor: ConstColor(context)
                      .getConstColor(ConstColorEnum.kBgColor.name),
                  radius: 70,
                  child: ClipOval(
                    child: Image.network(
                      userImagePath,
                      loadingBuilder: (context, child, event) {
                        if (event == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              value: event.cumulativeBytesLoaded /
                                  (event.expectedTotalBytes ?? 1),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 100.0,
          left: 100.0,
          child: CircleAvatar(
            child: user.isUserVerified
                ? const Icon(Icons.verified, color: Colors.greenAccent)
                : const Icon(Icons.lock, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
