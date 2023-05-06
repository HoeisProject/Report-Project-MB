import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_user_controller.dart';
import 'package:report_project/admin/screens/admin_user_verify.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class AdminUserHomeScreen extends ConsumerWidget {
  static const routeName = '/admin-employee-home';

  const AdminUserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppbar("User Management"),
      body: _body(context, ref),
    );
  }

  Widget _body(context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _listUserView(context, ref),
      ),
    );
  }

  Widget _listUserView(BuildContext context, WidgetRef ref) {
    final users = ref.watch(adminUserControllerProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        elevation: 5.0,
        child: users.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                  child: Text('NO DATA', style: TextStyle(fontSize: 36.0)));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: (1 / 1.5),
              ),
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return _listUserViewItem(context, data[index]);
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
                child: Text(
              '${error.toString()} occurred',
              style: const TextStyle(fontSize: 18),
            ));
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _listUserViewItem(BuildContext context, UserModel user) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AdminUserVerifyScreen.routeName,
                arguments: user,
              );
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _listItemHeader(context, user.userImage.toString(), user.id),
                  _listItemContent(
                    user.nickname.toString(),
                    user.isUserVerified
                        ? const Icon(Icons.verified, color: Colors.greenAccent)
                        : const Icon(Icons.lock, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItemHeader(BuildContext context, String imagePath, String id) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CircleAvatar(
        radius: 72,
        backgroundColor: ConstColor(context)
            .getConstColor(ConstColorEnum.kOutlineBorderColor.name),
        child: Hero(
          tag: id,
          child: CircleAvatar(
            backgroundColor:
                ConstColor(context).getConstColor(ConstColorEnum.kBgColor.name),
            radius: 70,
            child: ClipOval(
              child: Image.network(
                imagePath,
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
    );
  }

  Widget _listItemContent(String text, Widget? trailing) {
    return ListTile(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          text,
          style: kContentReportItem,
          maxLines: 1,
        ),
      ),
      trailing: trailing,
    );
  }
}
