import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_user_controller.dart';
import 'package:report_project/admin/screens/admin_user_verify.dart';
import 'package:report_project/common/models/user_model.dart';
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
            return ListView.builder(
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
    // return ListTile(
    //   title: Text(user.username.toString()),
    //   subtitle: Text(user.nickname.toString()),
    //   trailing: user.isUserVerified
    //       ? const Icon(Icons.verified, color: Colors.green)
    //       : const Icon(Icons.lock, color: Colors.red),
    //   onTap: () {},
    // );

    /// TODO UI nya di sesuaikan selera aja ler.
    /// Kode UI terinpirasi dari admin_project_home.dart
    /// Anjer lupa gw cara padding dah WWKWKWK
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      height: 70.0,
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
                arguments: AdminUserVerifyArguments(
                  id: user.id,
                  isUserVerified: user.isUserVerified,
                  nik: user.nik,
                  ktpImage: user.ktpImage,
                ),
              );
            },
            child: Row(children: [
              Expanded(child: Text(user.nickname.toString())),
              user.isUserVerified
                  ? const Icon(Icons.verified, color: Colors.green)
                  : const Icon(Icons.lock, color: Colors.red),
            ]),
          ),
        ),
      ),
    );
  }
}
