import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_user_controller.dart';
import 'package:report_project/admin/view_model/admin_user_verify_view_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/custom_button.dart';
import 'package:report_project/common/widgets/show_image_full_func.dart';
import 'package:report_project/common/widgets/show_snack_bar.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminUserVerifyScreen extends ConsumerWidget {
  static const routeName = '/admin-user-verify';

  const AdminUserVerifyScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  void submit(context, int isApprove, WidgetRef ref) async {
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
                sizedSpacer(context: context, height: 10.0),
                _userImageHeader(context, user.userImage, user.id),
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
                _ktpImageHolder(context, user.id),
                sizedSpacer(context: context, height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: customButton(
                          context,
                          ref.watch(adminUserVerifyIsLoadingProvider),
                          "REJECT",
                          Colors.red,
                          () => submit(context, UserStatus.reject.value, ref)),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: customButton(
                          context,
                          ref.watch(adminUserVerifyIsLoadingProvider),
                          "APPROVE",
                          Colors.greenAccent,
                          () => submit(context, UserStatus.approve.value, ref)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userImageHeader(
    BuildContext context,
    String userImagePath,
    String id,
  ) {
    return Center(
      child: SizedBox(
        width: 144.0,
        height: 144.0,
        child: Stack(
          children: [
            Center(
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
                          id: id,
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
                    tag: id,
                    child: CircleAvatar(
                      backgroundColor: ConstColor(context)
                          .getConstColor(ConstColorEnum.kBgColor.name),
                      radius: 70,
                      child: ClipOval(
                        child: Image.network(
                          userImagePath,
                          fit: BoxFit.fill,
                          width: 140.0,
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
                radius: 20.0,
                child: _userImageHeaderTrailing(user.status),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TODO Trailing Icon 4 variasi untuk semua kondisi status ??
  Widget _userImageHeaderTrailing(int status) {
    if (UserStatus.pending.value == status) {
      return const Icon(Icons.lock, color: Colors.red);
    }
    if (UserStatus.approve.value == status) {
      return const Icon(Icons.verified, color: Colors.greenAccent);
    }
    if (UserStatus.reject.value == status) {
      return const Icon(Icons.lock, color: Colors.red);
    }
    // status no upload
    return const Icon(Icons.verified, color: Colors.greenAccent);
  }

  Widget _ktpImageHolder(context, String id) {
    return Center(
      child: SizedBox(
        height: 200.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowImageFullFunc(
                  id: "$id${user.ktpImage ?? user.nik}",
                  listMediaFilePath: [user.ktpImage ?? user.nik],
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
          },
          child: Hero(
            tag: "$id${user.ktpImage ?? user.nik}",
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
        ),
      ),
    );
  }
}
