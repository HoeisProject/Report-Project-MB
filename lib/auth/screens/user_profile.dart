import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/auth/controllers/profile_controller.dart';
import 'package:report_project/auth/widgets/account_verify.dart';
import 'package:report_project/auth/widgets/user_profile_edit_image.dart';
import 'package:report_project/auth/widgets/user_profile_edit_text.dart';
import 'package:report_project/common/controller/role_controller.dart';
import 'package:report_project/common/models/role_model.dart';
import 'package:report_project/common/models/user_model.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/common/widgets/show_image_full_func.dart';
import 'package:report_project/common/widgets/sized_spacer.dart';
import 'package:report_project/common/widgets/view_with_icon.dart';
import 'package:report_project/employee/widgets/custom_appbar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const routeName = '/user-profile';

  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: customAppbar("USER PROFILE"),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 10.0),
        child: user.when(
          data: (data) {
            /// It should not be null, Because every home employee / admin has ref.listen to check authentication
            if (data == null) return Container();
            final role = ref
                .read(roleControllerProvider.notifier)
                .findById(data.roleId)
                .name;
            return SingleChildScrollView(
              child: Column(
                children: [
                  profileHeader(
                    ConstColor(context)
                        .getConstColor(ConstColorEnum.kOutlineBorderColor.name),
                    data.nickname,
                    data.userImage,
                    data.id,
                  ),
                  Visibility(
                    visible: UserStatus.reject.value == data.status,
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flexible(
                            child: Text(
                              "your account got rejected,\nplease resend ktp image and NIK\nby pressing edit button",
                              style: kTitleReportItem.apply(
                                  color: Theme.of(context).primaryColor),
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: UserStatus.pending.value == data.status &&
                        data.ktpImage != null,
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flexible(
                            child: Text(
                              "Wait for admin to verify your account\nfor full access",
                              style: kTitleReportItem.apply(
                                  color: Theme.of(context).primaryColor),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedSpacer(
                    context: context,
                    height: 20,
                    width: 225,
                    thickness: 1.0,
                  ),
                  ViewWithIcon(
                    text: data.phoneNumber,
                    iconLeading: Icons.phone,
                    iconTrailing: Icons.edit,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext dialogContext) {
                          return UserProfileEditText(
                            label: "phone number",
                            oldValue: data.phoneNumber,
                            iconLeading: Icons.phone,
                            onPressed: () {},
                            inputType: TextInputType.phone,
                            obscureText: false,
                            userModelEnum: UserModelEnum.phoneNumber,
                          );
                        },
                      );
                    },
                  ),
                  ViewWithIcon(
                    text: data.email,
                    iconLeading: Icons.email,
                    iconTrailing: Icons.edit,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext dialogContext) {
                          return UserProfileEditText(
                            label: "email",
                            oldValue: data.email,
                            iconLeading: Icons.email,
                            onPressed: () {},
                            inputType: TextInputType.emailAddress,
                            obscureText: false,
                            userModelEnum: UserModelEnum.email,
                          );
                        },
                      );
                    },
                  ),
                  role == RoleModelNameEnum.employee.name
                      ? ktpField(
                          context,
                          data.nik,
                          data.ktpImage,
                          data.id,
                          data.status,
                        )
                      : Container(),
                  sizedSpacer(context: context, height: 25.0),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Container();
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget profileHeader(
      Color color, String nickname, String userImagePath, String id) {
    return Column(
      children: [
        Center(
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
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    mini: true,
                    elevation: 0.0,
                    shape: const CircleBorder(),
                    tooltip: "Change Image",
                    child: const Icon(
                      Icons.edit,
                      size: 15.0,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext dialogContext) {
                          return UserProfileEditImage(
                            label: "profile image",
                            oldImage: userImagePath,
                            userModelEnum: UserModelEnum.userImage,
                            onPressed: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        ViewWithIcon(
          text: nickname,
          iconLeading: Icons.person,
          iconTrailing: Icons.edit,
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return UserProfileEditText(
                  label: "Nickname",
                  oldValue: nickname,
                  iconLeading: Icons.person,
                  onPressed: () {},
                  inputType: TextInputType.text,
                  obscureText: false,
                  userModelEnum: UserModelEnum.nickname,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

Widget ktpField(
  context,
  String? nik,
  String? ktpImagePath,
  String id,
  int status,
) {
  if (UserStatus.noupload.value == status) {
    return Container(
      margin: const EdgeInsets.only(top: 25.0),
      height: 50.0,
      width: 250.0,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (dialogContext) {
              return const AccountVerify();
            },
          );
        },
        child: const Text(
          "Account Verification",
          style: kButtonTextStyle,
        ),
      ),
    );
  }

  return Column(
    children: [
      ViewWithIcon(
        text: nik ?? '-',
        iconLeading: Icons.credit_card,
        iconTrailing: Icons.edit,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return UserProfileEditText(
                label: "NIK",
                oldValue: nik ?? '-',
                iconLeading: Icons.credit_card,
                onPressed: () {},
                inputType: TextInputType.number,
                obscureText: false,
                userModelEnum: UserModelEnum.nik,
              );
            },
          );
        },
      ),
      sizedSpacer(context: context, height: 25.0),
      Center(
        child: SizedBox(
          width: 225.0,
          height: 175.0,
          child: ktpImagePath != null
              ? Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowImageFullFunc(
                              id: id,
                              listMediaFilePath: [ktpImagePath],
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
                        child: Center(
                          child: Image.network(
                            ktpImagePath,
                            width: 200,
                            height: 150,
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
                    Positioned(
                      top: 125.0,
                      left: 175.0,
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        mini: true,
                        elevation: 0.0,
                        shape: const CircleBorder(),
                        tooltip: "Change Image",
                        child: const Icon(
                          Icons.edit,
                          size: 15.0,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext dialogContext) {
                              return UserProfileEditImage(
                                label: "ktp image",
                                oldImage: ktpImagePath,
                                userModelEnum: UserModelEnum.ktpImage,
                                onPressed: () {},
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const InkWell(
                  onTap: null,
                  child: Icon(Icons.add_a_photo, size: 50.0),
                ),
        ),
      ),
    ],
  );
}
