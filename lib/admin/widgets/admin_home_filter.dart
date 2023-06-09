import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/admin/controllers/admin_project_controller.dart';
import 'package:report_project/admin/view_model/admin_home_view_model.dart';
import 'package:report_project/common/styles/constant.dart';

class AdminHomeFilterMenu extends ConsumerStatefulWidget {
  const AdminHomeFilterMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AdminHomeFilterMenuState();
}

class AdminHomeFilterMenuState extends ConsumerState<AdminHomeFilterMenu> {
  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(adminProjectControllerProvider);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: 350.0,
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color:
              ConstColor(context).getConstColor(ConstColorEnum.kBgColor.name),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                filterDialogDropdownItem(
                  context,
                  "Project Status",
                  ref,
                  statusDropdown(ref),
                ),
                projects.when(
                  data: (data) {
                    final projectCategories = [
                      const DropdownMenuItem(
                        value: 'All',
                        child: SizedBox(
                          width: 100.0,
                          child: Text('All'),
                        ),
                      ),
                      ...data.map((e) {
                        return DropdownMenuItem(
                          value: e.id,
                          child: SizedBox(
                            width: 100.0,
                            child: Text(e.name),
                          ),
                        );
                      }).toList()
                    ];
                    return filterDialogDropdownItem(
                      context,
                      "Project Category",
                      ref,
                      projectCategoryDropdown(context, ref, projectCategories),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Text('Error Happen');
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Close",
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterDialogDropdownItem(
      BuildContext context, String fieldLabel, WidgetRef ref, Widget child) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
            child: Text(
              "$fieldLabel : ",
              style: kHeaderTextStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: child,
          ),
        ],
      ),
    );
  }

  List<String> statusFilter = [
    "All",
    "Pending",
    "Approved",
  ];

  List<DropdownMenuItem<String>> statusDropdownItem() {
    List<DropdownMenuItem<String>> items = [];
    items = statusFilter.map((e) {
      return DropdownMenuItem(
        value: e,
        child: SizedBox(
          width: 100.0,
          child: Text(e),
        ),
      );
    }).toList();
    return items;
  }

  Widget statusDropdown(WidgetRef ref) {
    return DropdownButton(
      value: ref.watch(adminHomeStatusSelectedLabelProvider),
      onChanged: (value) {
        ref.read(adminHomeStatusSelectedLabelProvider.notifier).state = value!;
        ref.read(adminHomeStatusSelectedProvider.notifier).state =
            (statusFilter.indexOf(value.toString()));
      },
      items: statusDropdownItem(),
    );
  }

  Widget projectCategoryDropdown(BuildContext context, WidgetRef ref,
      List<DropdownMenuItem<String>>? items) {
    return DropdownButton(
      value: ref.watch(adminHomeProjectCategorySelectedProvider),
      onChanged: (value) {
        ref.read(adminHomeProjectCategorySelectedProvider.notifier).state =
            value!;
      },
      items: items,
    );
  }
}
