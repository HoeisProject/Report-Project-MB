import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/common/styles/constant.dart';
import 'package:report_project/employee/view_model/employee_home_view_model.dart';

class EmployeeHomeFilterMenu extends ConsumerStatefulWidget {
  const EmployeeHomeFilterMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      EmployeeHomeFilterMenuState();
}

class EmployeeHomeFilterMenuState
    extends ConsumerState<EmployeeHomeFilterMenu> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height / 2,
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
                  statusDropdown(context, ref),
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
                      )),
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
    "Rejected",
  ];

  List<DropdownMenuItem<String>> get statusDropdownItem {
    List<DropdownMenuItem<String>> items = [];
    items = statusFilter.map((e) {
      return DropdownMenuItem(
          value: e,
          child: SizedBox(
            width: 100.0,
            child: Text(e),
          ));
    }).toList();
    return items;
  }

  Widget statusDropdown(BuildContext context, WidgetRef ref) {
    return DropdownButton(
      value: ref.watch(employeeHomeStatusSelectedLabelProvider),
      onChanged: (value) {
        ref.read(employeeHomeStatusSelectedLabelProvider.notifier).state =
            value!;
        ref.read(employeeHomeStatusSelectedProvider.notifier).state =
            (statusFilter.indexOf(value.toString()));
      },
      items: statusDropdownItem,
    );
  }
}
